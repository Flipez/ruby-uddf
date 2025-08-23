# frozen_string_literal: true

require "happymapper"
require "nokogiri"

require "uddf/version"

# Universal Dive Data Format (UDDF) parser and validator
module UDDF
  SUPPORTED_SCHEMA_VERSIONS = %w[3.0.0 3.0.1 3.1.0 3.2.0 3.2.1 3.2.2 3.2.3 3.3.0 3.3.1].freeze
  SUPPORTED_PARSER_VERSIONS = %w[3.2.3 3.3.0].freeze

  @schema_cache_mutex = Mutex.new

  def self.load(path, force_version: nil)
    xml = File.read(path)
    parse(xml, force_version: force_version)
  end

  def self.parse(xml, force_version: nil)
    version = force_version || extract_version(xml)
    model_class = load_models_for_version(version)

    model_class.parse(xml)
  end

  def self.validate(xml, force_version: nil)
    version = force_version || extract_version(xml)
    schema = load_schema_for_version(version)
    doc = Nokogiri::XML::Document.parse(xml)

    schema.validate(doc)
  end

  def self.extract_version(xml)
    doc = Nokogiri::XML(xml)
    doc.root&.[]("version")
  end

  def self.load_schema_for_version(version)
    @schema_cache_mutex.synchronize do
      @schema_cache ||= {}
      @schema_cache[version] ||= begin
        validate_version_support(version, :schema)
        schema_path = File.join(__dir__, "uddf", "v#{version.tr(".", "")}", "schema.xsd")
        Nokogiri::XML::Schema.new(File.read(schema_path))
      end
    end
  end

  def self.load_models_for_version(version)
    validate_version_support(version, :parse)

    case version
    when "3.2.3"
      require "uddf/v323/models"
      V323::Models::Uddf
    when "3.3.0"
      require "uddf/v330/models"
      V330::Models::Uddf
    end
  end

  def self.validate_version_support(version, operation)
    supported = case operation
                when :parse then SUPPORTED_PARSER_VERSIONS
                when :schema then SUPPORTED_SCHEMA_VERSIONS
                end

    return if supported.include?(version)

    raise "Unsupported UDDF version for #{operation}, got '#{version}'"
  end
end
