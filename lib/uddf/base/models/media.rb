# frozen_string_literal: true

module UDDF
  module Base
    module Models
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
    end
  end
end
