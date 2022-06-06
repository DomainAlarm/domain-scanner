# Template/Interface for a Domain Name Matcher
require_relative 'match_result'
require_relative 'matcher_manager'

class Matcher

  # Checks if a domain matches the monitored domain
  # @param [String] monitored_domain The domain being monitored
  # @param [String] suspect_domain The domain being checked
  # @return [MatchResult] The match result, or nil if no match
  def self.get_match_result(monitored_domain, suspect_domain)
    raise NotImplementedError.new "This is a base class, subclass and write your own implementation"
  end

end