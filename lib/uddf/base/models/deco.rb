# frozen_string_literal: true

module UDDF
  module Base
    module Models
      class Tissue
        include HappyMapper

        tag "tissue"

        attribute :gas, String
        attribute :half_life, Float, tag: "halflife"
        attribute :number, Integer
        attribute :a, Float
        attribute :b, Float
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
        has_many :tissues, Tissue, tag: "tissue"
      end

      class BuehlmannV320
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

        content :value, String
      end

      class DecoModelV310
        include HappyMapper

        tag "decomodel"

        has_many :buehlmanns, Buehlmann, tag: "buehlmann"
        has_many :rgbms, RGBM, tag: "rbgm"
        has_many :vpms, VPM, tag: "vpm"
      end

      class DecoModelV320
        include HappyMapper

        tag "decomodel"

        has_many :buehlmanns, BuehlmannV320, tag: "buehlmann"
        has_many :rgbms, RGBM, tag: "rbgm"
        has_many :vpms, VPM, tag: "vpm"
      end
    end
  end
end
