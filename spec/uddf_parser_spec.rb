# frozen_string_literal: true

require_relative "spec_helper"

# Shared helper methods for UDDF parsing and validation
module UDDFParserHelpers
  def parse_uddf_file(file_path)
    UDDF.load(file_path)
  end

  def validate_dive_basic_fields(dive, expected_fields = {})
    expect(dive).not_to be_nil
    expect(dive).to respond_to(:id)

    expect(dive.id).to eq(expected_fields[:id]) if expected_fields[:id]

    if expected_fields[:dive_number]
      expect(dive.information_before_dive).not_to be_nil
      expect(dive.information_before_dive.dive_number).to eq(expected_fields[:dive_number])
    end

    return unless expected_fields[:datetime]

    expect(dive.information_before_dive).not_to be_nil
    expect(dive.information_before_dive.datetime).to eq(expected_fields[:datetime])
  end

  def validate_dive_samples_present(dive)
    expect(dive.samples).not_to be_nil
    expect(dive.samples.waypoints).not_to be_empty

    # Verify basic waypoint structure
    first_waypoint = dive.samples.waypoints.first
    expect(first_waypoint).to respond_to(:depth)
    expect(first_waypoint).to respond_to(:dive_time)
  end

  def validate_dive_site_info(uddf_data, expected_site_fields = {})
    expect(uddf_data.dive_site).not_to be_nil

    return unless expected_site_fields[:sites_count]

    expect(uddf_data.dive_site.sites.length).to eq(expected_site_fields[:sites_count])
  end

  def validate_diver_info(uddf_data, expected_diver_fields = {})
    expect(uddf_data.diver).not_to be_nil

    return unless expected_diver_fields[:dive_computers_count] && uddf_data.diver.owner

    expect(uddf_data.diver.owner.equipment.dive_computers.length).to eq(expected_diver_fields[:dive_computers_count])
  end

  def validate_generator_info(uddf_data, expected_generator_fields = {})
    expect(uddf_data.generator).not_to be_nil

    expect(uddf_data.generator.name).to eq(expected_generator_fields[:name]) if expected_generator_fields[:name]

    return unless expected_generator_fields[:type]

    expect(uddf_data.generator.type).to eq(expected_generator_fields[:type])
  end

  def validate_multiple_uddf_files(file_paths, expected_dive_counts = {})
    file_paths.each do |file_path|
      puts "Testing file: #{file_path}"
      uddf_data = parse_uddf_file(file_path)

      expect(uddf_data).not_to be_nil

      # Count total dives across all repetition groups
      # Some UDDF files may not have profile data (e.g., files with only diver/equipment data)
      total_dives = if uddf_data.profile_data && uddf_data.profile_data.repetition_groups
                      uddf_data.profile_data.repetition_groups.sum { |rg| rg.dives.length }
                    else
                      0
                    end

      if expected_dive_counts[file_path]
        expect(total_dives).to eq(expected_dive_counts[file_path])
      else
        expect(total_dives).to be >= 0
      end
    end
  end
end

RSpec.configure do |config|
  config.include UDDFParserHelpers
end

describe "UDDF Parser" do
  describe "parsing Peregrine TX UDDF file" do
    let(:file_path) { File.join(__dir__, "../test_files/v323/realworld/Peregrine TX[93CBB2BB]#140_2025-03-21.uddf") }
    let(:uddf_data) { parse_uddf_file(file_path) }

    it "successfully parses the UDDF file" do
      expect(uddf_data).not_to be_nil
      expect(uddf_data.version).to eq("3.2.3")
    end

    it "contains correct generator information" do
      validate_generator_info uddf_data, {
        name: "Shearwater Cloud Desktop",
        type: "logbook"
      }
    end

    it "contains diver information with dive computer" do
      validate_diver_info uddf_data, {
        dive_computers_count: 1
      }
    end

    it "contains dive site information" do
      validate_dive_site_info uddf_data, {
        sites_count: 1
      }
    end

    it "contains profile data with dives" do
      expect(uddf_data.profile_data).not_to be_nil
      expect(uddf_data.profile_data.repetition_groups).not_to be_empty

      repetition_group = uddf_data.profile_data.repetition_groups.first
      expect(repetition_group).not_to be_nil
      expect(repetition_group.dives).not_to be_empty
    end

    it "correctly parses dive #140 details" do
      repetition_group = uddf_data.profile_data.repetition_groups.first
      dive = repetition_group.dives.first

      validate_dive_basic_fields dive, {
        id: "636812201742559648",
        dive_number: 140
      }
    end

    it "contains dive sample data (waypoints)" do
      repetition_group = uddf_data.profile_data.repetition_groups.first
      dive = repetition_group.dives.first

      validate_dive_samples_present dive
    end

    it "contains dive duration and depth information" do
      repetition_group = uddf_data.profile_data.repetition_groups.first
      dive = repetition_group.dives.first

      expect(dive.information_after_dive).not_to be_nil
      expect(dive.information_after_dive.dive_duration).to be > 0
      expect(dive.information_after_dive.greatest_depth).to be > 0
    end

    it "contains tank data when present" do
      repetition_group = uddf_data.profile_data.repetition_groups.first
      dive = repetition_group.dives.first

      unless dive.tank_data.empty?
        tank = dive.tank_data.first
        expect(tank).to respond_to(:tank_pressure_begin)
        expect(tank).to respond_to(:tank_pressure_end)
      end
    end
  end

  describe "parsing multiple UDDF files" do
    let(:test_files_dir) { File.join(__dir__, "../test_files") }
    let(:uddf_files) { Dir.glob(File.join(test_files_dir, "**", "*.uddf")) }

    it "can parse all available UDDF files" do
      skip "No UDDF files found" if uddf_files.empty?
      skip "Only one UDDF file available" if uddf_files.length <= 1

      validate_multiple_uddf_files(uddf_files)
    end

    it "handles different UDDF file formats consistently" do
      skip "Need multiple files for consistency testing" if uddf_files.length <= 1

      uddf_files.each do |file_path|
        uddf_data = parse_uddf_file(file_path)

        # Basic structure should be consistent across all files
        expect(uddf_data).not_to be_nil
        expect(uddf_data.version).to match(/^\d+\.\d+\.\d+$/)
        expect(uddf_data.generator).not_to be_nil
      end
    end
  end
end
