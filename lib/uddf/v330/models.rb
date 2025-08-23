# frozen_string_literal: true

require "happymapper"
require "uddf/base/models"

module UDDF
  module V330
    module Models
      class Timer
        include HappyMapper

        tag "timer"

        attribute :ref, String
        content :value, Float
      end

      class SelfTest
        include HappyMapper

        tag "selftest"

        attribute :ref, String
        content :Value, String
      end

      class RebreatherSelfTest
        include HappyMapper

        tag "rebreatherselftest"

        attribute :ref, String
        content :value, String
      end

      class DeepStops
        include HappyMapper

        tag "deepstops"

        has_one :deep_stop_time, Float, tag: "deepstoptime"
        has_one :deep_stop_type, String, tag: "deepstoptype"
      end

      class ScrubberMonitor
        include HappyMapper

        tag "scrubbermonitor"

        attribute :id, String
      end

      class Scrubber
        include HappyMapper

        tag "scrubber"

        attribute :ref, String
        attribute :units, String

        content :value, Float
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

      class Tissue
        include HappyMapper

        tag "tissue"

        attribute :gas, String
        attribute :half_life, Float
        attribute :number, Integer
        attribute :a, Float
        attribute :b, Float
      end

      class VPM
        include HappyMapper

        tag "vpm"

        attribute :id, String
        has_one :conservatism, Float
        has_one :gamma, Float
        has_one :gc, Float
        has_one :lambda, Float
        has_one :r0, Float
        has_many :tissues, Tissue, tag: "tissue"
      end

      class RGBM
        include HappyMapper

        tag "rgbm"

        attribute :id, String
        has_many :tissues, Tissue, tag: "tissue"
      end

      class Buehlmann
        include HappyMapper

        tag "buehlmann"

        attribute :id, String
        has_one :gradient_factor_high, Float, tag: "gradientfactorhigh"
        has_one :gradient_factor_low, Float, tag: "gradientfactorlow"
        has_many :tissues, Tissue, tag: "tissue"
      end

      class DecoModel
        include HappyMapper

        tag "decomodel"

        has_many :buehlmanns, Buehlmann, tag: "buehlmann"
        has_many :rgbms, RGBM, tag: "rbgm"
        has_many :vpms, VPM, tag: "vpm"
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

      class WayAltitude
        include HappyMapper

        tag "wayaltitude"

        attribute :way_time, Float
        content :value, Float
      end

      class ExposureToAltitude
        include HappyMapper

        tag "exposuretoaltitude"

        has_one :altitude_of_exposure, Float, tag: "altitudeofexposure"
        has_one :date_of_flight, Base::Models::DateTimeField, tag: "dateofflight"
        has_one :surface_interval_before_altitude_exposure, Float, tag: "surfaceintervalbeforealtitudeexposure"
        has_one :total_length_of_exposure, Float, tag: "totallengthofexposure"
        has_one :transportation, String
      end

      class SurfaceIntervalBeforeDive
        include HappyMapper

        tag "surfaceintervalbeforedive"

        has_one :exposure_to_altitude, ExposureToAltitude, tag: "exposuretoaltitude"
        has_one :infinity, String
        has_one :passed_time, Float, tag: "passedtime"
        has_many :way_altitudes, WayAltitude, tag: "wayaltitude"
      end

      class SurfaceIntervalAfterDive
        include HappyMapper

        tag "surfaceintervalafterdive"

        has_one :exposure_to_altitude, ExposureToAltitude, tag: "exposuretoaltitude"
        has_one :infinity, String
        has_one :passed_time, Float, tag: "passedtime"
        has_many :way_altitudes, WayAltitude, tag: "wayaltitude"
      end

      class TankPressure
        include HappyMapper

        tag "tankpressure"

        attribute :ref, String
        content :value, Float
      end

      class SwitchMix
        include HappyMapper

        tag "switchmix"

        attribute :ref, String
      end

      class SetPo2
        include HappyMapper

        tag "setpo2"

        attribute :set_by, String
        content :value, Float
      end

      class PPo2
        include HappyMapper

        tag "ppo2"

        attribute :ref, String
        content :value, Float
      end

      class GradientFactor
        include HappyMapper

        tag "gradientfactor"

        attribute :tissue, Integer
        content :value, Float
      end

      class DiveMode
        include HappyMapper

        tag "divemode"

        attribute :type, String
      end

      class Decostop
        include HappyMapper

        tag "decostop"

        attribute :kind, String
        attribute :deco_depth, Float
        attribute :duration, Float
      end

      class Battery
        include HappyMapper

        tag "battery"

        attribute :ref, String
      end

      class BatteryChargeCondition
        include HappyMapper

        tag "batterychargecondition"

        attribute :ref, String
        content :value, Float
      end

      class BatteryVoltage
        include HappyMapper

        tag "batteryvoltage"

        attribute :ref, String
        content :value, Float
      end

      class Alarm
        include HappyMapper

        tag "alarm"

        attribute :level, Float
        attribute :tank_ref, String
        content :value, String
      end

      class Info
        include HappyMapper

        tag "info"

        attribute :ref, String
        attribute :level, String
        attribute :type, String
        attribute :values, Float
        attribute :units, String
      end

      class PPCo2
        include HappyMapper

        tag "ppco2"

        attribute :ref, String

        content :value, Float
      end

      class Waypoint
        include HappyMapper

        tag "waypoint"

        has_many :alarms, Alarm, tag: "alarm"
        has_many :battery_charge_conditions, BatteryChargeCondition, tag: "batterychargecondition"
        has_many :battery_voltages, BatteryVoltage, tag: "batteryvoltage"
        has_one :calculated_po2, Float, tag: "calculatedpo2"
        has_one :cns, Float
        has_many :deco_stops, Decostop, tag: "decostop"
        has_one :depth, Float
        has_one :dive_mode, DiveMode, tag: "divemode"
        has_one :dive_time, Float, tag: "divetime"
        has_one :gradient_factor, GradientFactor, tag: "gradientfactor"
        has_one :heading, Float
        has_many :ppo2s, PPo2, tag: "ppo2"
        has_one :no_deco_time, Float, tag: "nodecotime"
        has_one :otu, Float
        has_one :remaining_bottom_time, Float, tag: "remainingbottomtime"
        has_one :remaining_o2_time, Float, tag: "remainingo2time"
        has_many :set_po2s, SetPo2, tag: "setpo2"
        has_one :switch_mix, SwitchMix, tag: "switchmix"
        has_many :tank_pressures, TankPressure, tag: "tankpressure"
        has_one :temperature, Float
        has_many :timers, Timer, tag: "timer"
        has_many :infos, Info, tag: "info"
        has_many :ppco2s, PPCo2, tag: "ppco2"
        has_many :scrubbers, Scrubber, tag: "scrubber"
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

      class PlannedProfile
        include HappyMapper

        tag "plannedprofile"

        attribute :start_dive_mode, String
        attribute :start_mix, String
        has_many :waypoints, Waypoint, tag: "waypoint"
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

      class InformationBeforeDive
        include HappyMapper

        tag "informationbeforedive"

        has_one :air_temperature, Float, tag: "airtemperature"
        has_one :alcohol_before_dive, AlcoholBeforeDive, tag: "alcoholbeforedive"
        has_one :altitude, Float
        has_one :apparatus, String
        has_one :datetime, DateTime
        has_one :deep_stops, DeepStops, tag: "deepstops"
        has_one :dive_number, Integer, tag: "divenumber"
        has_one :dive_number_of_day, Integer, tag: "divenumberofday"
        has_one :internal_dive_number, Integer, tag: "internaldivenumber"
        has_many :links, Link, tag: "link"
        has_one :medication_before_dive, MedicationBeforeDive, tag: "medicationbeforedive"
        has_one :no_suit, String, tag: "nosuit"
        has_one :planned_profile, PlannedProfile, tag: "plannedprofile"
        has_one :platform, String
        has_one :price, Price
        has_one :purpose, String
        has_many :rebreather_self_tests, RebreatherSelfTest, tag: "rebreatherselftest"
        has_one :state_of_rest_before_dive, String, tag: "stateofrestbeforedive"
        has_many :self_tests, SelfTest, tag: "selftest"
        has_one :surface_interval_before_dive, SurfaceIntervalBeforeDive, tag: "surfaceintervalbeforedive"
        has_one :surface_pressure, Float, tag: "surfacepressure"
        has_one :trip_membership, String, tag: "tripmembership"
        has_many :timers, Timer, tag: "timer"
      end

      class Rating
        include HappyMapper

        tag "rating"

        has_one :datetime, DateTime
        has_one :rating_value, Integer, tag: "ratingvalue"
      end

      class GlobalAlarmsGiven
        include HappyMapper

        tag "globalalarmsgiven"

        has_many :global_alarms, String, tag: "globalalarm"
      end

      class EquipmentUsed
        include HappyMapper

        tag "equipmentused"

        has_one :lead_quantity, Float, tag: "leadquantity"
        has_many :links, Link, tag: "link"
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

      class InformationAfterDive
        include HappyMapper

        tag "informationafterdive"

        has_one :any_symptoms, AnySymptoms, tag: "anysymptoms"
        has_one :average_depth, Float, tag: "averagedepth"
        has_one :current, String
        has_one :desaturation_time, Float, tag: "desaturationtime"
        has_one :dive_duration, Float, tag: "diveduration"
        has_one :dive_plan, String, tag: "diveplan"
        has_one :dive_table, String, tag: "divetable"
        has_one :equipment_malfunction, String, tag: "equipmentmalfunction"
        has_one :equipment_used, EquipmentUsed, tag: "equipmentused"
        has_one :global_alarms_given, GlobalAlarmsGiven, tag: "globalalarmsgiven"
        has_one :greatest_depth, Float, tag: "greatestdepth"
        has_one :highest_po2, Float, tag: "highestpo2"
        has_one :lowest_temperature, Float, tag: "lowesttemperature"
        has_one :no_flight_time, Float, tag: "noflighttime"
        has_one :notes, Notes
        has_one :observations, Observations
        has_one :pressure_drop, Float, tag: "pressuredrop"
        has_many :problems, String, tag: "problems"
        has_one :program, String
        has_many :ratings, Rating, tag: "rating"
        has_one :surface_interval_after_dive, SurfaceIntervalAfterDive, tag: "surfaceintervalafterdive"
        has_one :thermal_comfort, String, tag: "thermalcomfort"
        has_many :timers, Timer, tag: "timer"
        has_one :visibility, Float
        has_one :workload, String
      end

      class Samples
        include HappyMapper

        tag "samples"

        has_many :waypoints, Waypoint, tag: "waypoint"
      end

      class TankData
        include HappyMapper

        tag "tankdata"

        attribute :id, String

        has_one :analysed_he, Float, tag: "analysedhe"
        has_one :analysed_o2, Float, tag: "analysedo2"
        has_one :breathing_consumption_volume, Float, tag: "breathingconsumptionvolume"
        has_many :links, Link, tag: "link"
        has_one :tank_pressure_begin, Float, tag: "tankpressurebegin"
        has_one :tank_pressure_end, Float, tag: "tankpressureend"
        has_one :tank_volume, Float, tag: "tankvolume"
      end

      class Hargikas
        include HappyMapper

        tag "hargikas"

        has_one :ambient, Float
        has_many :tissues, Tissue, tag: "tissue"
        has_one :arterial_micro_bubble_level, Integer, tag: "arterialmicrobubbleLevel"
        has_one :intrapulmonary_right_left_shunt, Float, tag: "intrapulmonaryrightleftshunt"
        has_one :estimated_skin_cool_level, Integer, tag: "estimatedskincoolLevel"
      end

      class ApplicationData
        include HappyMapper

        tag "applicationdata"

        has_one :deco_trainer, String, tag: "decotrainer"
        has_one :hargikas, Hargikas
        has_one :apdiving, String
        has_one :ratio, String
      end

      class Dive
        include HappyMapper

        tag "dive"

        attribute :id, String
        has_one :information_after_dive, InformationAfterDive, tag: "informationafterdive"
        has_one :information_before_dive, InformationBeforeDive, tag: "informationbeforedive"
        has_one :application_data, ApplicationData, tag: "applicationdata"
        has_one :samples, Samples
        has_many :tank_data, TankData, tag: "tankdata"
      end

      class RepetitionGroup
        include HappyMapper

        tag "repetitiongroup"

        attribute :id, String
        has_many :dives, Dive, tag: "dive"
      end

      class ProfileData
        include HappyMapper

        tag "profiledata"

        has_many :repetition_groups, RepetitionGroup, tag: "repetitiongroup"
      end

      class Descent
        include HappyMapper

        tag "descent"

        has_many :waypoints, Waypoint, tag: "waypoint"
      end

      class Ascent
        include HappyMapper

        tag "ascent"

        has_many :waypoints, Waypoint, tag: "waypoint"
      end

      class MixChange
        include HappyMapper

        tag "mixchange"

        has_one :ascent, Ascent
        has_one :descent, Descent
      end

      class InputProfile
        include HappyMapper

        tag "inputprofile"

        has_many :links, Link, tag: "link"
        has_many :waypoints, Waypoint, tag: "waypoint"
      end

      class Output
        include HappyMapper

        tag "output"

        has_one :lingo, String
        has_one :file_format, String, tag: "fileformat"
        has_one :file_name, String, tag: "filename"
        has_one :headline, String
        has_one :remark, String
      end

      class Profile
        include HappyMapper

        tag "profile"

        has_one :application_data, ApplicationData, tag: "applicationdata"
        has_one :deco_model, DecoModel, tag: "decomodel"
        has_one :deep_stops, DeepStops, tag: "deepstops"
        has_one :density, Float
        has_one :input_profile, InputProfile, tag: "inputprofile"
        has_many :links, Link, tag: "link"
        has_one :maximum_ascending_rate, Float, tag: "maximumascendingrate"
        has_one :mix_change, MixChange, tag: "mixchange"
        has_one :output, Output
        has_one :surface_interval_after_dive, SurfaceIntervalAfterDive, tag: "surfaceintervalafterdive"
        has_one :surface_interval_before_dive, SurfaceIntervalBeforeDive, tag: "surfaceintervalbeforedive"
        has_one :title, String
      end

      class TableScope
        include HappyMapper

        tag "tablescope"

        has_one :altitude, Float
        has_one :bottom_time_maximum, Float, tag: "bottomtimemaximum"
        has_one :bottom_time_minimum, Float, tag: "bottomtimeminimum"
        has_one :bottom_time_step_begin, Float, tag: "bottomtimestepbegin"
        has_one :bottom_time_step_end, Float, tag: "bottomtimestepend"
        has_one :dive_depth_begin, Float, tag: "divedepthbegin"
        has_one :dive_depth_end, Float, tag: "divedepthend"
        has_one :dive_depth_step, Float, tag: "divedepthstep"
      end

      class Table
        include HappyMapper

        tag "table"

        has_one :table_scope, TableScope, tag: "tablescope"
        has_one :deep_stops, DeepStops, tag: "deepstops"
      end

      class CalculateProfile
        include HappyMapper

        tag "calculateprofile"

        has_many :profiles, Profile, tag: "profile"
      end

      class CalculateTable
        include HappyMapper

        tag "calculatetable"

        has_many :tables, Table, tag: "table"
      end

      class BottomTimeTableScope
        include HappyMapper

        tag "bottomtimetablescope"

        has_one :breathing_consumption_volume_begin, Float, tag: "breathingconsumptionvolumebegin"
        has_one :breathing_consumption_volume_end, Float, tag: "breathingconsumptionvolumeend"
        has_one :breathing_consumption_volume_step, Float, tag: "breathingconsumptionvolumestep"
        has_one :dive_depth_begin, Float, tag: "divedepthbegin"
        has_one :dive_depth_end, Float, tag: "divedepthend"
        has_one :dive_depth_step, Float, tag: "divedepthstep"
        has_one :tank_pressure_begin, Float, tag: "tankpressurebegin"
        has_one :tank_pressure_reserve, Float, tag: "tankpressurereserve"
        has_one :tank_volume_begin, Float, tag: "tankvolumebegin"
        has_one :tank_volume_end, Float, tag: "tankvolumeend"
      end

      class BottomTimeTable
        include HappyMapper

        tag "bottomtimetable"

        attribute :id, String
        has_one :application_data, ApplicationData, tag: "applicationdata"
        has_one :bottom_time_table_scope, BottomTimeTableScope, tag: "bottomtimetablescope"
        has_many :links, Link, tag: "link"
        has_one :output, Output
        has_one :title, String
      end

      class CalculateBottomTimeTable
        include HappyMapper

        tag "calculatebottomtimetable"

        has_many :bottom_time_tables, BottomTimeTable, tag: "bottomtimetable"
      end

      class TableGeneration
        include HappyMapper

        tag "tablegeneration"

        has_one :calculate_bottom_time_table, CalculateBottomTimeTable, tag: "calculatebottomtimetable"
        has_one :calculate_profile, CalculateProfile, tag: "calculateprofile"
        has_one :calculate_table, CalculateTable, tag: "calculatetable"
      end

      class ImageData
        include HappyMapper

        tag "imagedata"

        has_one :aperture, Float
        has_one :datetime, DateTime
        has_one :exposure_compensation, Float, tag: "exposurecompensation"
        has_one :film_speed, Integer, tag: "filmspeed"
        has_one :focal_length, Float, tag: "focallength"
        has_one :focusing_distance, Float, tag: "focusingdistance"
        has_one :metering_method, String, tag: "meteringmethod"
        has_one :shutter_speed, Float, tag: "shutterspeed"
      end

      class Image
        include HappyMapper

        tag "image"

        attribute :id, String
        attribute :height, Integer
        attribute :width, Integer
        attribute :format, String
        has_one :image_data, ImageData, tag: "imagedata"
        has_one :object_name, String, tag: "objectname"
        has_one :title, String
      end

      class Video
        include HappyMapper

        tag "video"

        attribute :id, String
        has_one :object_name, String, tag: "objectname"
        has_one :title, String
      end

      class Audio
        include HappyMapper

        tag "audio"

        attribute :id, String
        has_one :object_name, String, tag: "objectname"
        has_one :title, String
      end

      class MediaData
        include HappyMapper

        tag "mediadata"

        has_many :audio_files, Audio, tag: "audio"
        has_many :image_files, Image, tag: "image"
        has_many :video_files, Video, tag: "video"
      end

      class Maker
        include HappyMapper

        tag "maker"

        has_many :manufacturers, Manufacturer, tag: "manufacturer"
      end

      class PriceDivePackage
        include HappyMapper

        tag "pricedivepackage"

        attribute :currency, String
        attribute :no_of_dives, Integer
        content :value, Float
      end

      class RelatedDives
        include HappyMapper

        tag "relateddives"

        has_many :links, Link, tag: "link"
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

      class Vessel
        include HappyMapper

        tag "vessel"

        has_one :address, Base::Models::Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Base::Models::Contact
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
        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
      end

      class DateOfTrip
        include HappyMapper

        tag "dateoftrip"

        attribute :start_date, DateTime
        attribute :end_date, DateTime
      end

      class Accommodation
        include HappyMapper

        tag "accommodation"

        has_one :address, Base::Models::Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :category, String
        has_one :contact, Base::Models::Contact
        has_one :name, String
        has_one :notes, Notes
        has_many :ratings, Rating, tag: "rating"
      end

      class Geography
        include HappyMapper

        tag "geography"

        has_one :address, Base::Models::Address
        has_one :altitude, Float
        has_one :latitude, Float
        has_one :location, String
        has_one :longitude, Float
        has_one :time_zone, Float, tag: "timezone"
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

      class Ecology
        include HappyMapper

        tag "ecology"

        has_one :fauna, Fauna
        has_one :flora, Flora
      end

      class Built
        include HappyMapper

        tag "built"

        has_one :launching_date, Base::Models::DateTimeField, tag: "launchingdate"
        has_one :ship_yard, String, tag: "shipyard"
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
        has_one :sunk, Base::Models::DateTimeField
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

        has_one :address, Base::Models::Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Base::Models::Contact
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

      class Guide
        include HappyMapper

        tag "guide"

        has_many :links, Link, tag: "link"
      end

      class DiveBase
        include HappyMapper

        tag "divebase"

        attribute :id, String
        has_one :address, Base::Models::Address
        has_many :alias_names, String, tag: "aliasname"
        has_one :contact, Base::Models::Contact
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

      class Shop
        include HappyMapper

        tag "shop"

        has_many :alias_names, String, tag: "aliasname"
        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
        has_one :name, String
        has_one :notes, Notes
      end

      class Business
        include HappyMapper

        tag "business"

        has_one :shop, Shop
      end

      class Membership
        include HappyMapper

        tag "membership"

        attribute :organisation, String
        attribute :member_id, String
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

        has_one :birth_date, Base::Models::DateTimeField, tag: "birthdate"
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

        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
        has_one :personal, Personal
      end

      class Certification
        include HappyMapper

        tag "certification"

        has_one :certificate_number, String, tag: "certificatenumber"
        has_one :instructor, Instructor
        has_one :issue_date, Base::Models::DateTimeField, tag: "issuedate"
        has_one :level, String
        has_one :link, Link
        has_one :organization, String
        has_one :specialty, String
        has_one :valid_date, Base::Models::DateTimeField, tag: "validdate"
      end

      class Education
        include HappyMapper

        tag "education"

        has_many :certifications, Certification, tag: "certification"
      end

      class Insurance
        include HappyMapper

        tag "insurance"

        has_many :alias_names, String, tag: "aliasname"
        has_one :issue_date, Base::Models::DateTimeField, tag: "issuedate"
        has_one :name, String
        has_one :notes, Notes
        has_one :valid_date, Base::Models::DateTimeField, tag: "validdate"
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
        has_one :issue_date, Base::Models::DateTimeField, tag: "issuedate"
        has_one :name, String
        has_one :notes, Notes
        has_one :region, String
        has_one :valid_date, Base::Models::DateTimeField, tag: "validdate"
      end

      class DivePermissions
        include HappyMapper

        tag "divepermissions"

        has_many :permits, Permit, tag: "permit"
      end

      class Purchase
        include HappyMapper

        tag "purchase"

        has_one :datetime, DateTime
        has_one :link, Link
        has_one :price, Price
        has_one :shop, Shop
      end

      class TemperatureSensor
        include HappyMapper

        tag "temperaturesensor"

        attribute :id, String

        has_many :alias_names, String, tag: "aliasname"
        has_one :manufacturer, Manufacturer
        has_one :model, String
        has_one :name, String
        has_one :next_service_date, Base::Models::DateTimeField, tag: "nextservicedate"
        has_one :notes, Notes
        has_one :purchase, Purchase
        has_one :serial_number, String, tag: "serialnumber"
        has_one :service_interval, Integer, tag: "serviceinterval"
      end

      class TimerDevice
        include HappyMapper

        tag "timerdevice"

        attribute :id, String
      end

      class EquipmentPart
        include HappyMapper

        tag "equipmentpart"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_many :links, Link, tag: "link"
        has_one :manufacturer, Manufacturer
        has_one :model, String
        has_one :name, String
        has_one :next_service_date, Base::Models::DateTimeField, tag: "nextservicedate"
        has_one :notes, Notes
        has_one :purchase, Purchase
        has_one :serial_number, String, tag: "serialnumber"
        has_one :service_interval, Integer, tag: "serviceinterval"
      end

      class Lead < EquipmentPart
        include HappyMapper

        tag "lead"

        has_one :lead_quantity, Integer, tag: "leadquantity"
      end

      class Rebreather < EquipmentPart
        include HappyMapper

        tag "rebreather"

        has_many :batteries, Battery, tag: "battery"
        has_many :o2_sensors, EquipmentPart, tag: "o2sensor"
        has_many :scrubber_monitors, ScrubberMonitor, tag: "scrubbermonitor"
        has_many :temperature_sensors, TemperatureSensor, tag: "temperaturesensor"
        has_many :timer_devices, TimerDevice, tag: "timerdevice"
      end

      class Suit < EquipmentPart
        include HappyMapper

        tag "suit"

        has_one :suit_type, String, tag: "suittype"
      end

      class Tank < EquipmentPart
        include HappyMapper

        tag "tank"

        has_one :tank_material, String, tag: "tankmaterial"
        has_one :tank_volume, Float, tag: "tankvolume"
        has_many :batteries, Battery, tag: "battery"
      end

      class Camera
        include HappyMapper

        tag "camera"

        has_one :body, EquipmentPart
        has_many :flashes, EquipmentPart, tag: "flash"
        has_one :housing, EquipmentPart
        has_one :lens, EquipmentPart
      end

      class DiveComputer < EquipmentPart
        include HappyMapper

        tag "divecomputer"

        has_many :batteries, Battery, tag: "battery"
        has_many :timer_devices, TimerDevice, tag: "timerdevice"
      end

      class EquipmentContent
        include HappyMapper

        has_many :boots, EquipmentPart, tag: "boots"
        has_many :buoyancy_control_devices, EquipmentPart, tag: "buoyancycontroldevice"
        has_many :cameras, Camera, tag: "camera"
        has_many :compasses, EquipmentPart, tag: "compass"
        has_many :dive_computers, DiveComputer, tag: "divecomputer"
        has_many :fins, EquipmentPart, tag: "fins"
        has_many :gloves, EquipmentPart, tag: "gloves"
        has_many :knives, EquipmentPart, tag: "knife"
        has_many :leads, Lead, tag: "lead"
        has_many :lights, EquipmentPart, tag: "light"
        has_many :masks, EquipmentPart, tag: "mask"
        has_many :rebreathers, Rebreather, tag: "rebreather"
        has_many :regulators, EquipmentPart, tag: "regulator"
        has_many :scooters, EquipmentPart, tag: "scooter"
        has_many :suits, Suit, tag: "suit"
        has_many :tanks, Tank, tag: "tank"
        has_many :various_pieces, EquipmentPart, tag: "variouspieces"
        has_many :video_cameras, EquipmentPart, tag: "videocamera"
        has_many :watches, EquipmentPart, tag: "watch"
      end

      class EquipmentConfiguration < EquipmentContent
        include HappyMapper

        tag "equipmentconfiguration"

        has_many :alias_names, String, tag: "aliasname"
        has_many :links, Link, tag: "link"
        has_one :name, String
        has_one :notes, Notes
      end

      class Equipment < EquipmentContent
        include HappyMapper

        tag "equipment"

        has_many :compressors, EquipmentPart, tag: "compressor"
        has_one :equipment_configuration, EquipmentConfiguration, tag: "equipmentconfiguration"
      end

      class Doctor
        include HappyMapper

        tag "doctor"

        attribute :id, String
        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
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

      class BuddyOwnerShared
        include HappyMapper

        attribute :id, String
        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
        has_one :dive_insurances, DiveInsurances, tag: "diveinsurances"
        has_one :dive_permissions, DivePermissions, tag: "divepermissions"
        has_one :equipment, Equipment
        has_one :medical, Medical
        has_one :notes, Notes
        has_one :personal, Personal
      end

      class Buddy < BuddyOwnerShared
        include HappyMapper

        tag "buddy"

        attribute :id, String
        has_one :certification, Certification
        has_one :student, String
      end

      class Owner < BuddyOwnerShared
        include HappyMapper

        tag "owner"

        attribute :id, String
        has_one :education, Education
      end

      class Diver
        include HappyMapper

        tag "diver"

        has_many :buddies, Buddy, tag: "buddy"
        has_one :owner, Owner
      end

      class DCAlarm
        include HappyMapper

        tag "dcalarm"

        has_one :acknowledge, String
        has_one :alarm_type, Integer, tag: "alarmtype"
        has_one :period, Float
      end

      class SetDCDiveDepthAlarm
        include HappyMapper

        tag "setdcdivedethalarm"

        has_one :dc_alarm, DCAlarm
        has_one :dc_alarm_depth, Float
      end

      class SetDCDivePo2Alarm
        include HappyMapper

        tag "setdcdivepo2alarm"

        has_one :dc_alarm, DCAlarm
        has_one :maximum_po2, Float
      end

      class SetDCDiveSiteData
        include HappyMapper

        tag "setdcdivesitedata"

        attribute :dive_site, String
      end

      class SetDCDiveTimeAlarm
        include HappyMapper

        tag "setdcdivetimealarm"

        has_one :dc_alarm, DCAlarm
        has_one :timespan, Float
      end

      class SetDCEndNDTAlarm
        include HappyMapper

        tag "setdcendndtalarm"

        has_one :dc_alarm, DCAlarm
      end

      class SetDCDecoModel
        include HappyMapper

        tag "setdcdecomodel"

        has_many :alias_names, String, tag: "aliasname"
        has_one :application_data, ApplicationData
        has_one :name, String
      end

      class SetDCBuddyData
        include HappyMapper

        tag "setdcbuddydata"

        attribute :buddy, String
      end

      class SetDCData
        include HappyMapper

        tag "setdcdata"

        has_one :set_dc_alarm_time, DateTime
        has_one :set_dc_altitude, Float
        has_one :set_dc_buddy_data, SetDCBuddyData
        has_one :set_dc_date_time, DateTime
        has_one :set_dc_deco_model, SetDCDecoModel
        has_one :set_dc_dive_depth_alarm, SetDCDiveDepthAlarm
        has_one :set_dc_dive_po2_alarm, SetDCDivePo2Alarm
        has_many :set_dc_dive_site_data, SetDCDiveSiteData, tag: "setdcdivesitedata"
        has_one :set_dc_dive_time_alarm, SetDCDiveTimeAlarm
        has_one :set_dc_end_ndt_alarm, SetDCEndNDTAlarm
        has_one :set_dc_gas_definitions_data, String
        has_one :set_dc_owner_data, String
        has_one :set_dc_password, String
        has_one :set_dc_generator_data, String
      end

      class GetDCData
        include HappyMapper

        tag "getdcdata"

        has_one :get_dc_all_data, String
        has_one :get_dc_generator_data, String
        has_one :get_dc_owner_data, String
        has_one :get_dc_buddy_data, String
        has_one :get_dc_gas_definitions_data, String
        has_one :get_dc_dive_site_data, String
        has_one :get_dc_dive_trip_data, String
        has_one :get_dc_profile_data, String
      end

      class DiveComputerDump
        include HappyMapper

        tag "divecomputerdump"

        has_one :datetime, DateTime
        has_one :dc_dump, String
        has_one :link, Link
      end

      class DiveComputerControl
        include HappyMapper

        tag "divecomputercontrol"

        has_many :dive_computer_dumps, DiveComputerDump, tag: "divecomputerdump"
        has_one :get_dc_data, GetDCData, tag: "getdcdata"
        has_one :set_dc_data, SetDCData, tag: "setdcdata"
      end

      class Uddf
        include HappyMapper

        tag "uddf"

        attribute :version, String
        has_one :business, Business
        has_one :deco_model, DecoModel, tag: "decomodel"
        has_one :dive_computer_control, DiveComputerControl, tag: "divecomputercontrol"
        has_one :diver, Diver
        has_one :dive_site, DiveSite, tag: "divesite"
        has_one :dive_trip, DiveTrip, tag: "divetrip"
        has_one :gas_definitions, GasDefinitions, tag: "gasdefinitions"
        has_one :generator, Generator
        has_one :maker, Maker
        has_one :media_data, MediaData, tag: "mediadata"
        has_one :profile_data, ProfileData, tag: "profiledata"
        has_one :table_generation, TableGeneration, tag: "tablegeneration"
      end
    end
  end
end
