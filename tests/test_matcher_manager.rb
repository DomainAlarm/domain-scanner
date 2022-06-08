# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require 'minitest'
require 'minitest/autorun'

require_relative '../lib/matchers/matcher_manager'

class TestMatcherManager < MiniTest::Test

  def test_has_all_matchers
    puts MatcherManager.matchers.inspect
  end

end