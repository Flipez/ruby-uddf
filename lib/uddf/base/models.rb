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
    end
  end
end
