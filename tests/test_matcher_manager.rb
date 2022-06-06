require 'minitest'
require 'minitest/autorun'

require_relative '../lib/matchers/matcher_manager'

class TestMatcherManager < MiniTest::Test

  def test_has_all_matchers
    puts MatcherManager.matchers.inspect
  end

end