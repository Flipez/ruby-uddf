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
              rescue ArgumentError, DateError
                begin
                  DateTime.rfc3339(content)
                rescue ArgumentError, DateError
                  DateTime.parse(content)
                end
              end
            end
        end

        # Allow manual assignment if you ever need it
        attr_writer :date_time
      end

      class Manufacturer
        include HappyMapper

        tag "manufacturer"

        attribute :id, String
        has_one :address, Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Contact
        has_one :name, String
      end

      class Link
        include HappyMapper

        tag "link"

        attribute :ref, String
      end

      class Generator
        include HappyMapper

        tag "generator"

        has_many :alias_names, String, tag: "aliasname"
        has_one :datetime, DateTime
        has_many :links, Link, tag: "link"
        has_one :name, String
        has_one :type, String
        has_one :version, String
      end

      class Notes
        include HappyMapper

        tag "notes"

        has_many :paras, String, tag: "para"
        has_many :links, Link, tag: "link"
      end

      class Price
        include HappyMapper

        tag "price"

        attribute :currency, String
        content :value, Float
      end

      class Shop
        include HappyMapper

        tag "shop"

        has_many :alias_names, String, tag: "aliasname"
        has_one :address, Address
        has_one :contact, Contact
        has_one :name, String
        has_one :notes, Notes
      end

      class Purchase
        include HappyMapper

        tag "purchase"

        has_one :datetime, DateTime
        has_one :link, Link
        has_one :price, Price
        has_one :shop, Shop
      end

      class Mix
        include HappyMapper

        tag "mix"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :ar, Float
        has_one :equivalent_air_depth, Float, tag: "equivalentairdepth"
        has_one :h2, Float
        has_one :he, Float
        has_one :maximum_operation_depth, Float, tag: "maximumoperationdepth"
        has_one :maximum_po2, Float, tag: "maximumpo2"
        has_one :n2, Float
        has_one :name, String
        has_one :o2, Float
        has_one :price_per_litre, Price, tag: "priceperlitre"
      end

      class GasDefinitions
        include HappyMapper

        tag "gasdefinitions"

        has_many :mixes, Mix, tag: "mix"
      end

      class Medicine
        include HappyMapper

        tag "medicine"

        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
        has_one :periodically_taken, String, tag: "periodicallytaken"
        has_one :timespan_before_dive, Float, tag: "timespanbeforedive"
      end

      class MedicationBeforeDive
        include HappyMapper

        tag "medicationbeforedive"

        has_many :medicines, Medicine, tag: "medicine"
      end

      class Drink
        include HappyMapper

        tag "drink"

        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
        has_one :periodically_taken, String, tag: "periodicallytaken"
        has_one :timespan_before_dive, Float, tag: "timespanbeforedive"
      end

      class AlcoholBeforeDive
        include HappyMapper

        tag "alcoholbeforedive"

        has_many :drinks, Drink, tag: "drink"
      end

      class AnySymptoms
        include HappyMapper

        tag "anysymptoms"

        has_one :notes, Notes
      end

      class Abundance
        include HappyMapper

        tag "abundance"

        attribute :quality, String
        attribute :occurrence, String
        content :value, Integer
      end

      class Species
        include HappyMapper

        tag "species"

        attribute :id, String
        has_one :abundance, Abundance
        has_one :age, Integer
        has_one :dominance, String
        has_one :life_stage, String, tag: "lifestage"
        has_one :notes, Notes
        has_one :scientific_name, String, tag: "scientificname"
        has_one :sex, String
        has_one :size, Float
        has_one :trivial_name, String, tag: "trivialname"
      end

      class WithSpecies
        include HappyMapper

        has_many :species, Species, tag: "species"
      end

      class Invertebrata
        include HappyMapper

        tag "invertebrata"

        has_one :ascidiacea, WithSpecies
        has_one :bryozoan, WithSpecies
        has_one :cnidaria, WithSpecies
        has_one :coelenterata, WithSpecies
        has_one :crustacea, WithSpecies
        has_one :ctenophora, WithSpecies
        has_one :echinodermata, WithSpecies
        has_one :invertebrata_various, WithSpecies, tag: "invertebratavarious"
        has_one :mollusca, WithSpecies
        has_one :phoronidea, WithSpecies
        has_one :plathelminthes, WithSpecies
        has_one :porifera, WithSpecies
      end

      class Vertebrata
        include HappyMapper

        tag "vertebrata"

        has_one :amphibia, WithSpecies
        has_one :chondrichthyes, WithSpecies
        has_one :mammalia, WithSpecies
        has_one :osteichthyes, WithSpecies
        has_one :reptilia, WithSpecies
        has_one :vertebrata_various, WithSpecies, tag: "vertebratavarious"
      end

      class Fauna
        include HappyMapper

        tag "fauna"

        has_one :invertebrata, Invertebrata
        has_one :notes, Notes
        has_one :vertebrata, Vertebrata
      end

      class Flora
        include HappyMapper

        tag "flora"

        has_one :chlorophyceae, WithSpecies
        has_one :flora_various, WithSpecies, tag: "floravarious"
        has_one :notes, Notes
        has_one :phaeophyceae, WithSpecies
        has_one :rhodophyceae, WithSpecies
        has_one :spermatophyta, WithSpecies
      end

      class Observations
        include HappyMapper

        tag "observations"

        has_one :fauna, Fauna
        has_one :flora, Flora
        has_one :notes, Notes
      end

      class Geography
        include HappyMapper

        tag "geography"

        has_one :address, Address
        has_one :altitude, Float
        has_one :latitude, Float
        has_one :location, String
        has_one :longitude, Float
        has_one :time_zone, Float, tag: "timezone"
      end

      class Ecology
        include HappyMapper

        tag "ecology"

        has_one :fauna, Fauna
        has_one :flora, Flora
      end

      class Built
        include HappyMapper

        tag "built"

        has_one :launching_date, DateTimeField, tag: "launchingdate"
        has_one :ship_yard, String, tag: "shipyard"
      end

      class ShipDimension
        include HappyMapper

        tag "shipdimension"

        has_one :beam, Float
        has_one :displacement, Float
        has_one :draught, Float
        has_one :length, Float
        has_one :tonnage, Float
      end

      class Wreck
        include HappyMapper

        tag "wreck"

        has_many :alias_names, String, tag: "aliasname"
        has_one :built, Built
        has_one :name, String
        has_one :nationality, String
        has_one :ship_dimension, ShipDimension, tag: "shipdimension"
        has_one :ship_type, String, tag: "shiptype"
        has_one :sunk, DateTimeField
      end

      class Shore
        include HappyMapper

        tag "shore"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
      end

      class River
        include HappyMapper

        tag "river"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
      end

      class Lake
        include HappyMapper

        tag "lake"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
      end

      class Indoor
        include HappyMapper

        tag "indoor"

        has_one :address, Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Contact
        has_one :name, String
        has_one :notes, Notes
      end

      class Cave
        include HappyMapper

        tag "cave"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_one :notes, Notes
      end

      class SiteData
        include HappyMapper

        tag "sidedata"

        has_one :area_length, Float, tag: "arealength"
        has_one :area_width, Float, tag: "areawidth"
        has_one :average_visibility, Float, tag: "averagevisibility"
        has_one :bottom, String
        has_one :cave, Cave
        has_one :density, Float
        has_one :difficulty, Integer
        has_one :global_light_intensity, String, tag: "globallightintensity"
        has_one :indoor, Indoor
        has_one :maximum_depth, Float, tag: "maximumdepth"
        has_one :maximum_visibility, Float, tag: "maximumvisibility"
        has_one :minimum_depth, Float, tag: "minimumdepth"
        has_one :minimum_visibility, Float, tag: "minimumvisibility"
        has_one :river, River
        has_one :shore, Shore
        has_one :terrain, String
        has_one :wreck, Wreck
      end

      class Rating
        include HappyMapper

        tag "rating"

        has_one :datetime, DateTime
        has_one :rating_value, Integer, tag: "ratingvalue"
      end

      class Site
        include HappyMapper

        tag "site"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :ecology, Ecology
        has_one :environment, String
        has_one :geography, Geography
        has_many :links, Link, tag: "link"
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
        has_one :side_data, SiteData, tag: "sitedata"
      end

      class Membership
        include HappyMapper

        tag "membership"

        attribute :organisation, String
        attribute :member_id, String, tag: "memberid"
      end

      class NumberOfDives
        include HappyMapper

        tag "numberofdives"

        has_one :start_date, DateTime, tag: "startdate"
        has_one :end_date, DateTime, tag: "enddate"
        has_one :dives, Integer
      end

      class Personal
        include HappyMapper

        tag "personal"

        has_one :birth_date, DateTimeField, tag: "birthdate"
        has_one :birth_name, String, tag: "birthname"
        has_one :blood_group, String, tag: "bloodgroup"
        has_one :first_name, String, tag: "firstname"
        has_one :height, Float
        has_one :honorific, String
        has_one :last_name, String, tag: "lastname"
        has_one :membership, Membership
        has_one :middle_name, String, tag: "middlename"
        has_one :number_of_dives, NumberOfDives, tag: "numberofdives"
        has_one :sex, String
        has_one :smoking, String
        has_one :weight, Float
      end

      class Instructor
        include HappyMapper

        tag "instructor"

        has_one :address, Address
        has_one :contact, Contact
        has_one :personal, Personal
      end

      class Doctor
        include HappyMapper

        tag "doctor"

        attribute :id, String
        has_one :address, Address
        has_one :contact, Contact
        has_one :personal, Personal
      end

      class Examination
        include HappyMapper

        tag "examination"

        has_one :datetime, DateTime
        has_one :doctor, Doctor
        has_one :examination_result, String, tag: "examinationresult"
        has_many :links, Link, tag: "link"
        has_one :notes, Notes
        has_one :total_lung_capacity, Float, tag: "totallungcapacity"
        has_one :vital_capacity, Float, tag: "vitalcapacity"
      end

      class Medical
        include HappyMapper

        tag "medical"

        has_one :examination, Examination
      end

      class Certification
        include HappyMapper

        tag "certification"

        has_one :instructor, Instructor
        has_one :issue_date, DateTimeField, tag: "issuedate"
        has_one :level, String
        has_one :link, Link
        has_one :organization, String
        has_one :specialty, String
        has_one :valid_date, DateTimeField, tag: "validdate"
      end

      class CertificationV322 < Certification
        include HappyMapper

        # Added in v3.2.2
        has_one :certificate_number, String, tag: "certificatenumber"
      end

      class Education
        include HappyMapper

        tag "education"

        has_many :certifications, Certification, tag: "certification"
      end

      class EducationV322 < Education
        include HappyMapper

        has_many :certifications, CertificationV322, tag: "certification"
      end

      class Vessel
        include HappyMapper

        tag "vessel"

        has_one :address, Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Contact
        has_one :marina, String
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
        has_one :ship_dimension, ShipDimension, tag: "shipdimension"
        has_one :ship_type, String, tag: "shiptype"
      end

      class Operator
        include HappyMapper

        tag "operator"

        has_many :alias_names, String, tag: "aliasname"
        has_one :address, Address
        has_one :contact, Contact
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
      end

      class DateOfTrip
        include HappyMapper

        tag "dateoftrip"

        attribute :start_date, DateTime, tag: "startdate"
        attribute :end_date, DateTime, tag: "enddate"
      end

      class Accommodation
        include HappyMapper

        tag "accommodation"

        has_one :address, Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :category, String
        has_one :contact, Contact
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
      end

      class PriceDivePackage
        include HappyMapper

        tag "pricedivepackage"

        attribute :currency, String
        attribute :no_of_dives, Integer, tag: "noofdives"
        content :value, Float
      end

      class RelatedDives
        include HappyMapper

        tag "relateddives"

        has_many :links, Link, tag: "link"
      end

      class TripPart
        include HappyMapper

        tag "trippart"

        attribute :type, String
        has_one :accommodation, Accommodation
        has_one :date_of_trip, DateOfTrip, tag: "dateoftrip"
        has_one :geography, Geography
        has_many :links, Link, tag: "link"
        has_one :name, String
        has_one :notes, Notes
        has_one :operator, Operator
        has_one :price_dive_package, PriceDivePackage, tag: "pricedivepackage"
        has_one :price_per_dive, Price, tag: "priceperdive"
        has_one :related_dives, RelatedDives, tag: "relateddives"
        has_one :vessel, Vessel
      end

      class Trip
        include HappyMapper

        tag "trip"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_one :name, String
        has_many :ratings, Rating, tag: "rating"
        has_many :trip_parts, TripPart, tag: "trippart"
      end

      class DiveTrip
        include HappyMapper

        tag "divetrip"

        has_many :trips, Trip, tag: "trip"
      end

      class Guide
        include HappyMapper

        tag "guide"

        has_many :links, Link, tag: "link"
      end

      class DiveBase
        include HappyMapper

        tag "divebase"

        attribute :id, String
        has_one :address, Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Contact
        has_many :guides, Guide, tag: "guide"
        has_many :links, Link, tag: "link"
        has_one :name, String
        has_one :notes, Notes
        has_one :price_dive_package, PriceDivePackage, tag: "pricedivepackage"
        has_one :price_per_dive, Price, tag: "priceperdive"
        has_many :ratings, Rating, tag: "rating"
      end

      class DiveSite
        include HappyMapper

        tag "divesite"

        has_many :dive_bases, DiveBase, tag: "divebase"
        has_many :sites, Site, tag: "site"
      end

      class Insurance
        include HappyMapper

        tag "insurance"

        has_many :alias_names, String, tag: "aliasname"
        has_one :issue_date, DateTimeField, tag: "issuedate"
        has_one :name, String
        has_one :notes, Notes
        has_one :valid_date, DateTimeField, tag: "validdate"
      end

      class DiveInsurances
        include HappyMapper

        tag "diveinsurances"

        has_many :insurances, Insurance, tag: "insurance"
      end

      class Permit
        include HappyMapper

        tag "permit"

        has_many :alias_names, String, tag: "aliasname"
        has_one :issue_date, DateTimeField, tag: "issuedate"
        has_one :name, String
        has_one :notes, Notes
        has_one :region, String
        has_one :valid_date, DateTimeField, tag: "validdate"
      end

      class DivePermissions
        include HappyMapper

        tag "divepermissions"

        has_many :permits, Permit, tag: "permit"
      end
    end
  end
end
