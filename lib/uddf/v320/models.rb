# frozen_string_literal: true

require "happymapper"
require "uddf/base/models"

module UDDF
  module V320
    module Models
      class WayAltitude
        include HappyMapper

        tag "wayaltitude"

        attribute :way_time, Float, tag: "waytime"
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

        attribute :set_by, String, tag: "setby"
        content :value, Float
      end

      class MeasuredPo2
        include HappyMapper

        tag "measuredpo2"

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
        attribute :deco_depth, Float, tag: "decodepth"
        attribute :duration, Float
      end

      class BatteryChargeCondition
        include HappyMapper

        tag "batterychargecondition"

        attribute :device_ref, String, tag: "deviceref"
        attribute :tank_ref, String, tag: "tankref"
        content :value, Float
      end

      class Alarm
        include HappyMapper

        tag "alarm"

        attribute :level, Float
        attribute :tank_ref, String, tag: "tankref"
        content :value, String
      end

      class Waypoint
        include HappyMapper

        tag "waypoint"

        has_many :alarms, Alarm, tag: "alarm"
        has_many :battery_charge_conditions, BatteryChargeCondition, tag: "batterychargecondition"
        has_one :calculated_po2, Float, tag: "calculatedpo2"
        has_one :cns, Float
        has_many :deco_stops, Decostop, tag: "decostop"
        has_one :depth, Float
        has_one :dive_mode, DiveMode, tag: "divemode"
        has_one :dive_time, Float, tag: "divetime"
        has_one :gradient_factor, GradientFactor, tag: "gradientfactor"
        has_one :heading, Float
        has_many :measured_po2s, MeasuredPo2, tag: "measuredpo2"
        has_one :no_deco_time, Float, tag: "nodecotime"
        has_one :otu, Float
        has_one :remaining_bottom_time, Float, tag: "remainingbottomtime"
        has_one :remaining_o2_time, Float, tag: "remainingo2time"
        has_many :set_po2s, SetPo2, tag: "setpo2"
        has_one :switch_mix, SwitchMix, tag: "switchmix"
        has_many :tank_pressures, TankPressure, tag: "tankpressure"
        has_one :temperature, Float
      end

      class PlannedProfile
        include HappyMapper

        tag "plannedprofile"

        attribute :start_dive_mode, String, tag: "startdivemode"
        attribute :start_mix, String, tag: "startmix"
        has_many :waypoints, Waypoint, tag: "waypoint"
      end

      class InformationBeforeDive
        include HappyMapper

        tag "informationbeforedive"

        has_one :air_temperature, Float, tag: "airtemperature"
        has_one :alcohol_before_dive, Base::Models::AlcoholBeforeDive, tag: "alcoholbeforedive"
        has_one :altitude, Float
        has_one :apparatus, String
        has_one :datetime, DateTime
        has_one :dive_number, Integer, tag: "divenumber"
        has_one :dive_number_of_day, Integer, tag: "divenumberofday"
        has_one :internal_dive_number, Integer, tag: "internaldivenumber"
        has_many :links, Base::Models::Link, tag: "link"
        has_one :medication_before_dive, Base::Models::MedicationBeforeDive, tag: "medicationbeforedive"
        has_one :no_suit, String, tag: "nosuit"
        has_one :planned_profile, PlannedProfile, tag: "plannedprofile"
        has_one :platform, String
        has_one :price, Base::Models::Price
        has_one :purpose, String
        has_one :state_of_rest_before_dive, String, tag: "stateofrestbeforedive"
        has_one :surface_interval_before_dive, SurfaceIntervalBeforeDive, tag: "surfaceintervalbeforedive"
        has_one :surface_pressure, Float, tag: "surfacepressure"
        has_one :trip_membership, String, tag: "tripmembership"
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
        has_many :links, Base::Models::Link, tag: "link"
      end

      class InformationAfterDive
        include HappyMapper

        tag "informationafterdive"

        has_one :any_symptoms, Base::Models::AnySymptoms, tag: "anysymptoms"
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
        has_one :notes, Base::Models::Notes
        has_one :observations, Base::Models::Observations
        has_one :pressure_drop, Float, tag: "pressuredrop"
        has_many :problems, String, tag: "problems"
        has_one :program, String
        has_many :ratings, Base::Models::Rating, tag: "rating"
        has_one :surface_interval_after_dive, SurfaceIntervalAfterDive, tag: "surfaceintervalafterdive"
        has_one :thermal_comfort, String, tag: "thermalcomfort"
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
        has_one :breathing_consumption_volume, Float, tag: "breathingconsumptionvolume"
        has_many :links, Base::Models::Link, tag: "link"
        has_one :tank_pressure_begin, Float, tag: "tankpressurebegin"
        has_one :tank_pressure_end, Float, tag: "tankpressureend"
        has_one :tank_volume, Float, tag: "tankvolume"
      end

      class Dive
        include HappyMapper

        tag "dive"

        attribute :id, String
        has_one :information_after_dive, InformationAfterDive, tag: "informationafterdive"
        has_one :information_before_dive, InformationBeforeDive, tag: "informationbeforedive"
        has_one :application_data, Base::Models::ApplicationDataV310, tag: "applicationdata"
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

        has_many :links, Base::Models::Link, tag: "link"
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

        has_one :application_data, Base::Models::ApplicationDataV310, tag: "applicationdata"
        has_one :deco_model, Base::Models::DecoModelV320, tag: "decomodel"
        has_one :deep_stop_time, Float, tag: "deepstoptime"
        has_one :density, Float
        has_one :input_profile, InputProfile, tag: "inputprofile"
        has_many :links, Base::Models::Link, tag: "link"
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
        has_one :application_data, Base::Models::ApplicationDataV310, tag: "applicationdata"
        has_one :bottom_time_table_scope, BottomTimeTableScope, tag: "bottomtimetablescope"
        has_many :links, Base::Models::Link, tag: "link"
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

      class Maker
        include HappyMapper

        tag "maker"

        has_many :manufacturers, Base::Models::Manufacturer, tag: "manufacturer"
      end

      class Business
        include HappyMapper

        tag "business"

        has_one :shop, Base::Models::Shop
      end

      class EquipmentPart
        include HappyMapper

        tag "equipmentpart"

        attribute :id, String
        has_many :alias_names, String, tag: "aliasname"
        has_many :links, Base::Models::Link, tag: "link"
        has_one :manufacturer, Base::Models::Manufacturer
        has_one :model, String
        has_one :name, String
        has_one :next_service_date, Base::Models::DateTimeField, tag: "nextservicedate"
        has_one :notes, Base::Models::Notes
        has_one :purchase, Base::Models::Purchase
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

        has_many :o2_sensors, EquipmentPart, tag: "o2sensor"
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
      end

      class Camera
        include HappyMapper

        tag "camera"

        has_one :body, EquipmentPart
        has_many :flashes, EquipmentPart, tag: "flash"
        has_one :housing, EquipmentPart
        has_one :lens, EquipmentPart
      end

      class EquipmentContent
        include HappyMapper

        has_many :boots, EquipmentPart, tag: "boots"
        has_many :buoyancy_control_devices, EquipmentPart, tag: "buoyancycontroldevice"
        has_many :cameras, Camera, tag: "camera"
        has_many :compasses, EquipmentPart, tag: "compass"
        has_many :dive_computers, EquipmentPart, tag: "divecomputer"
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
        has_many :links, Base::Models::Link, tag: "link"
        has_one :name, String
        has_one :notes, Base::Models::Notes
      end

      class Equipment < EquipmentContent
        include HappyMapper

        tag "equipment"

        has_many :compressors, EquipmentPart, tag: "compressor"
        has_one :equipment_configuration, EquipmentConfiguration, tag: "equipmentconfiguration"
      end

      class BuddyOwnerShared
        include HappyMapper

        attribute :id, String
        has_one :address, Base::Models::Address
        has_one :contact, Base::Models::Contact
        has_one :dive_insurances, Base::Models::DiveInsurances, tag: "diveinsurances"
        has_one :dive_permissions, Base::Models::DivePermissions, tag: "divepermissions"
        has_one :equipment, Equipment
        has_one :medical, Base::Models::Medical
        has_one :notes, Base::Models::Notes
        has_one :personal, Base::Models::Personal
      end

      class Buddy < BuddyOwnerShared
        include HappyMapper

        tag "buddy"

        attribute :id, String
        has_one :certification, Base::Models::Certification
        has_one :student, String
      end

      class Owner < BuddyOwnerShared
        include HappyMapper

        tag "owner"

        attribute :id, String
        has_one :education, Base::Models::Education
      end

      class Diver
        include HappyMapper

        tag "diver"

        has_many :buddies, Buddy, tag: "buddy"
        has_one :owner, Owner
      end

      class Uddf
        include HappyMapper

        tag "uddf"

        attribute :version, String
        has_one :business, Business
        has_one :deco_model, Base::Models::DecoModelV320, tag: "decomodel"
        has_one :dive_computer_control, Base::Models::DiveComputerControlV310, tag: "divecomputercontrol"
        has_one :diver, Diver
        has_one :dive_site, Base::Models::DiveSite, tag: "divesite"
        has_one :dive_trip, Base::Models::DiveTrip, tag: "divetrip"
        has_one :gas_definitions, Base::Models::GasDefinitions, tag: "gasdefinitions"
        has_one :generator, Base::Models::Generator
        has_one :maker, Maker
        has_one :media_data, Base::Models::MediaData, tag: "mediadata"
        has_one :profile_data, ProfileData, tag: "profiledata"
        has_one :table_generation, TableGeneration, tag: "tablegeneration"
      end
    end
  end
end
