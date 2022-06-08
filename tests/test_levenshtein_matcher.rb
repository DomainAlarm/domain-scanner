# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require 'minitest'
require 'minitest/autorun'

require_relative '../lib/matchers/levenshtein_matcher'

class TestLevenshteinMatcher < MiniTest::Test

  def test_positive_cases
  end

  def test_negative_cases
    assert_nil(ExactMatcher.get_match_result("domain", "abc"), "Gave a positive result when shouldn't have")
  end

end