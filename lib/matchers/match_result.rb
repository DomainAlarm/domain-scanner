# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require "json"

# Represents a result from a Matcher
class MatchResult

  attr_accessor :monitored_domain, :matched_domain, :match_type, :match_ranges

  # Creates a new instance
  # @param [String] monitored_domain The domain being monitored
  # @param [String] matched_domain The domain that matched
  # @param [String] match_type The name of the match (includes, levenshtein, etc.)
  # @param [Array<Range>] match_ranges The ranges within the matched_domain that matched
  # @return [MatchResult] The new instance
  def initialize(monitored_domain, matched_domain, match_type, match_ranges=[])
    @monitored_domain = monitored_domain
    @matched_domain = matched_domain
    @match_type = match_type
    @match_ranges = match_ranges
  end

  # Converts this object to a hash
  # @return [Hash] The hash representation
  def to_hash
    {
      :monitored_domain => @monitored_domain,
      :matched_domain => @matched_domain,
      :match_type => @match_type,
      :match_ranges => @match_ranges
    }
  end

  # Returns the JSON representation of this object
  # @return [String] The JSON representation
  def to_json
    hashed = to_hash
    hashed[:match_ranges].map! {|x| [x.begin, x.end]}
    hashed.to_json
  end

end