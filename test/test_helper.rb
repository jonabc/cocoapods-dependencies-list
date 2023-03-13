# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

FIXTURES_DIRECTORY = File.expand_path("fixtures", __dir__)

require "debug"
require "cocoapods_dependencies_list"
require "minitest/autorun"
