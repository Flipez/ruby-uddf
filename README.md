[![Gem Version](https://badge.fury.io/rb/uddf.svg)](https://badge.fury.io/rb/uddf)

# UDDF

Ruby parser and validator for Universal Dive Data Format (UDDF) files. Supports multiple UDDF versions with version-specific model loading.

## Features

- Parse UDDF XML files into Ruby objects using HappyMapper
- Automatic version detection from UDDF files
- Version-specific model loading
- XML schema validation
- Extensible architecture for multiple UDDF versions

### Supported Versions

| UDDF Version | Parser | Validator |
|--------------|--------|-----------|
| 3.0.0        | ✗      | ✓         |
| 3.0.1        | ✗      | ✓         |
| 3.1.0        | ✗      | ✓         |
| 3.2.0        | ✗      | ✓         |
| 3.2.1        | ✗      | ✓         |
| 3.2.2        | ✗      | ✓         |
| 3.2.3        | ✓      | ✓         |
| 3.3.0        | ✗      | ✓         |
| 3.3.1        | ✗      | ✓         |

> **Note**: The UDDF 3.3.0 and 3.3.1 schema files included in this gem have been locally modified to fix XML Schema validation errors that prevented them from loading with Nokogiri. These fixes address syntax issues in the original schemas but may not represent the upstream maintainers' intentions. The modifications ensure compatibility with standard XML Schema validators while preserving the core schema structure and validation rules.

## Usage

```ruby
require 'uddf'

# Load and parse a UDDF file (auto-detects version)
dive_data = UDDF.load('path/to/dive.uddf')

# Parse UDDF XML string directly
dive_data = UDDF.parse(xml_string)

# Force a specific version (bypasses auto-detection)
dive_data = UDDF.load('path/to/dive.uddf', force_version: '3.2.3')
dive_data = UDDF.parse(xml_string, force_version: '3.2.3')

# Validate UDDF XML against schema
errors = UDDF.validate(xml_string)
errors = UDDF.validate(xml_string, force_version: '3.2.3')

# Access parsed data
puts dive_data.generator.name
dive_data.profile_data.repetition_groups.each do |group|
  group.dives.each do |dive|
    puts "Depth: #{dive.information_after_dive&.greatest_depth}m"
  end
end
```

## Installation

```ruby
gem 'uddf'
```

## Architecture

The gem uses a modular architecture with version-specific models:

- `UDDF::Models::Base` - Shared base models across versions
- `UDDF::Models::V323` - UDDF 3.2.3 specific models
- Automatic model loading based on file version attribute

