require 'minitest'
require 'minitest/autorun'

require_relative '../lib/matchers/includes_matcher'

class TestIncludesMatcher < MiniTest::Test

  def test_positive_cases
  end

  def test_negative_cases
    assert_nil(IncludesMatcher.get_match_result("domain", "abc"), "Gave a positive result when shouldn't have")
  end

end