require "damerau-levenshtein"
require_relative 'matcher'

# Checks if the suspect domain matches the monitored domain using Levenshtein Distance
class LevenshteinMatcher < Matcher

  MATCHER_NAME = "similar"

  # The maximum distance for a match
  @@max_distance = 1

  # Sets the maximum distance for a match
  # @param [Integer] val The max distance value
  def self.max_distance=(val)
    @@max_distance = val
  end

  # Retrieves the max distance
  # @return [Integer] The max distance
  def self.max_distance
    @@max_distance
  end

  # @see Matcher.get_match_result
  def self.get_match_result(monitored_domain, suspect_domain)
    distance = DamerauLevenshtein.distance(monitored_domain, suspect_domain)
    if distance <= @@max_distance
      MatchResult.new(monitored_domain, suspect_domain, MATCHER_NAME,
                      [])
    else
      nil
    end
  end

  MatcherManager.register(MATCHER_NAME, self)
end