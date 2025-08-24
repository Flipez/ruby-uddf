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

      class Manufacturer
        include HappyMapper

        tag "manufacturer"

        attribute :id, String
        has_one :address, Base::Models::Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Base::Models::Contact
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
    end
  end
end
