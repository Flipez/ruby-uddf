# frozen_string_literal: true

require_relative "../spec_helper"

describe "UDDF V321 Equipment Parser" do
  let(:equipment_file) { File.join(__dir__, "../../test_files/v321/snippets/equipment.uddf") }
  let(:equipment_xml) { File.read(equipment_file) }

  before do
    require "uddf/v321/models"
  end

  describe "Equipment.parse" do
    it "successfully parses equipment XML" do
      equipment = UDDF::V321::Models::Equipment.parse(equipment_xml)

      expect(equipment).not_to be_nil
    end

    it "allows access to equipment properties" do
      equipment = UDDF::V321::Models::Equipment.parse(equipment_xml)

      expect(equipment).to respond_to(:dive_computers)
      expect(equipment).to respond_to(:tanks)
      expect(equipment).to respond_to(:suits)
      expect(equipment).to respond_to(:masks)
      expect(equipment).to respond_to(:fins)
    end
  end
end
