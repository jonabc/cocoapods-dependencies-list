# frozen_string_literal: true

require "test_helper"

class Cocoapods::Dependencies::TestList < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cocoapods::Dependencies::List::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
