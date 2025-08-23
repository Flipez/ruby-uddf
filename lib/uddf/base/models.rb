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

        element :raw, String, tag: "datetime"

        # Lazily parse on first access; memoize in @date_time
        def date_time
          return @date_time if @date_time

          content = raw.to_s.strip
          return nil if content.empty?

          @date_time =
            case content
            when /^\d{4}$/               # "YYYY"
              DateTime.new(content.to_i, 1, 1)
            when /^\d{4}-\d{2}$/         # "YYYY-MM"
              y, m = content.split("-").map!(&:to_i)
              DateTime.new(y, m, 1)
            else
              begin
                DateTime.iso8601(content)
              rescue ArgumentError, Date::Error
                begin
                  DateTime.rfc3339(content)
                rescue ArgumentError, Date::Error
                  DateTime.parse(content)
                end
              end
            end
        end

        # Allow manual assignment if you ever need it
        attr_writer :date_time
      end
    end
  end
end
