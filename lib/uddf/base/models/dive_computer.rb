# frozen_string_literal: true

module UDDF
  module Base
    module Models
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

        has_one :dc_alarm, DCAlarm, tag: "dcalarm"
        has_one :dc_alarm_depth, Float, tag: "dcalarmdepth"
      end

      class SetDCDivePo2Alarm
        include HappyMapper

        tag "setdcdivepo2alarm"

        has_one :dc_alarm, DCAlarm, tag: "dcalarm"
        has_one :maximum_po2, Float, tag: "maximumpo2"
      end

      class SetDCDiveSiteData
        include HappyMapper

        tag "setdcdivesitedata"

        attribute :dive_site, String, tag: "divesite"
      end

      class SetDCDiveTimeAlarm
        include HappyMapper

        tag "setdcdivetimealarm"

        has_one :dc_alarm, DCAlarm, tag: "dcalarm"
        has_one :timespan, Float
      end

      class SetDCEndNDTAlarm
        include HappyMapper

        tag "setdcendndtalarm"

        has_one :dc_alarm, DCAlarm, tag: "dcalarm"
      end

      class ApplicationDataV300
        include HappyMapper

        tag "applicationdata"

        has_one :hargikas, Hargikas
      end

      class ApplicationDataV310 < ApplicationDataV300
        include HappyMapper

        tag "applicationdata"

        has_one :deco_trainer, String, tag: "decotrainer"
      end

      class ApplicationDataV330 < ApplicationDataV310
        include HappyMapper

        has_one :apdiving, String
        has_one :ratio, String
      end

      class SetDCDecoModelV300
        include HappyMapper

        tag "setdcdecomodel"

        has_many :alias_names, String, tag: "aliasname"
        has_one :application_data, ApplicationDataV300, tag: "applicationdata"
        has_one :name, String
      end

      class SetDCDecoModelV310 < SetDCDecoModelV300
        include HappyMapper

        has_one :application_data, ApplicationDataV310, tag: "applicationdata"
      end

      class SetDCDecoModelV330 < SetDCDecoModelV310
        include HappyMapper

        has_one :application_data, ApplicationDataV330, tag: "applicationdata"
      end

      class SetDCBuddyData
        include HappyMapper

        tag "setdcbuddydata"

        attribute :buddy, String
      end

      class SetDCDataV300
        include HappyMapper

        tag "setdcdata"

        has_one :set_dc_alarm_time, DateTime, tag: "setdcalarmtime"
        has_one :set_dc_altitude, Float, tag: "setdcaltitude"
        has_one :set_dc_buddy_data, SetDCBuddyData, tag: "setdcbuddydata"
        has_one :set_dc_date_time, DateTime, tag: "setdcdatetime"
        has_one :set_dc_deco_model, SetDCDecoModelV300, tag: "setdcdecomodel"
        has_one :set_dc_dive_depth_alarm, SetDCDiveDepthAlarm, tag: "setdcdivedethalarm"
        has_one :set_dc_dive_po2_alarm, SetDCDivePo2Alarm, tag: "setdcdivepo2alarm"
        has_many :set_dc_dive_site_data, SetDCDiveSiteData, tag: "setdcdivesitedata"
        has_one :set_dc_dive_time_alarm, SetDCDiveTimeAlarm, tag: "setdcdivetimealarm"
        has_one :set_dc_end_ndt_alarm, SetDCEndNDTAlarm, tag: "setdcendndtalarm"
        has_one :set_dc_gas_definitions_data, String, tag: "setdcgasdefinitionsdata"
        has_one :set_dc_owner_data, String, tag: "setdcownerdata"
        has_one :set_dc_password, String, tag: "setdcpassword"
        has_one :set_dc_generator_data, String, tag: "setdcgeneratordata"
      end

      class SetDCDataV310 < SetDCDataV300
        include HappyMapper

        has_one :set_dc_deco_model, SetDCDecoModelV310, tag: "setdcdecomodel"
      end

      class SetDCDataV330 < SetDCDataV310
        include HappyMapper

        has_one :set_dc_deco_model, SetDCDecoModelV330, tag: "setdcdecomodel"
      end

      class GetDCData
        include HappyMapper

        tag "getdcdata"

        has_one :get_dc_all_data, String, tag: "getdcalldata"
        has_one :get_dc_generator_data, String, tag: "getdcgeneratordata"
        has_one :get_dc_owner_data, String, tag: "getdcownerdata"
        has_one :get_dc_buddy_data, String, tag: "getdcbuddydata"
        has_one :get_dc_gas_definitions_data, String, tag: "getdcgasdefinitionsdata"
        has_one :get_dc_dive_site_data, String, tag: "getdcdivesitedata"
        has_one :get_dc_dive_trip_data, String, tag: "getdcdivetripdata"
        has_one :get_dc_profile_data, String, tag: "getdcprofiledata"
      end

      class DiveComputerDump
        include HappyMapper

        tag "divecomputerdump"

        has_one :datetime, DateTime
        has_one :dc_dump, String, tag: "dcdump"
        has_one :link, Link
      end

      class DiveComputerControlV300
        include HappyMapper

        tag "divecomputercontrol"

        has_many :dive_computer_dumps, DiveComputerDump, tag: "divecomputerdump"
        has_one :get_dc_data, GetDCData, tag: "getdcdata"
        has_one :set_dc_data, SetDCDataV300, tag: "setdcdata"
      end

      class DiveComputerControlV310 < DiveComputerControlV300
        include HappyMapper

        has_one :set_dc_data, SetDCDataV310, tag: "setdcdata"
      end

      class DiveComputerControlV330 < DiveComputerControlV310
        include HappyMapper

        has_one :set_dc_data, SetDCDataV330, tag: "setdcdata"
      end
    end
  end
end
