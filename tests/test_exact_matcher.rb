require 'minitest'
require 'minitest/autorun'

require_relative '../lib/matchers/exact_matcher'

class TestExactMatcher < MiniTest::Test

  def test_positive_cases
  end

  def test_negative_cases
    assert_nil(ExactMatcher.get_match_result("domain", "abc"), "Gave a positive result when shouldn't have")
  end

end