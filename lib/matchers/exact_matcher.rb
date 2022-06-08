# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require_relative './matcher'

# Checks if the suspect domain matches the monitored domain exactly
class ExactMatcher < Matcher

  MATCHER_NAME = "exact"

  # @see Matcher.get_match_result
  def self.get_match_result(monitored_domain, suspect_domain)
    if monitored_domain.downcase == suspect_domain.downcase
      MatchResult.new(monitored_domain, suspect_domain, MATCHER_NAME,
                      [Range.new(0, monitored_domain.size)])
    else
      nil
    end
  end

  MatcherManager.register(MATCHER_NAME, self)
end