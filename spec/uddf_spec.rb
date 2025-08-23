# frozen_string_literal: true

require_relative "spec_helper"

describe UDDF do
  it "has a version number" do
    expect(UDDF::VERSION).not_to be_nil
  end
end
