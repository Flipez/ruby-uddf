# frozen_string_literal: true

module UDDF
  module Base
    module Models
      ##
      # Inside <address> the own (<owner> element) address data,
      # or that of dive buddies (<buddy> element),
      # or that of a shop (<shop> element) etc., are given.
      class Address
        include HappyMapper

        tag "address"

        has_one :street, String
        has_one :city, String
        has_one :postcode, String
        has_one :country, String
        has_one :province, String
      end

      ##
      # Inside <contact> data concerning getting in touch with some one are
      # given, like phone number, email address, language etc.
      class Contact
        include HappyMapper

        tag "contact"

        has_many :emails, String, tag: "email"
        has_many :faxes, String, tag: "fax"
        has_many :homepages, String, tag: "homepage"
        has_many :languages, String, tag: "language"
        has_many :mobile_phones, String, tag: "mobilephone"
        has_many :phones, String, tag: "phone"
      end

      class DateTimeField
        include HappyMapper

        def self.parse(xml, options = {})
          result = super
          return result if result.nil?

          # Handle empty or whitespace-only content
          if result.date_time.nil? || (result.date_time.respond_to?(:strip) && result.date_time.strip.empty?)
            element_name = xml.name
            parent_name = xml.parent&.name
            context = parent_name ? "#{parent_name} > #{element_name}" : element_name
            raise Date::Error, "Empty datetime content in element: <#{context}>"
          end

          result
        rescue Date::Error => e
          # Handle year-only dates by converting to January 1st of that year
          datetime_element = xml.at_xpath(".//datetime")
          if datetime_element && datetime_element.content.strip.match(/^\d{4}$/)
            year = datetime_element.content.strip
            result = new
            result.date_time = DateTime.new(year.to_i, 1, 1)
            return result
          end

          # Re-raise Date::Error with element context if not already included
          unless e.message.include?("element:")
            element_name = xml.name
            parent_name = xml.parent&.name
            context = parent_name ? "#{parent_name} > #{element_name}" : element_name
            raise Date::Error, "#{e.message} in element: <#{context}>"
          end
          raise
        end

        has_one :date_time, DateTime, tag: "datetime"
      end
    end
  end
end
