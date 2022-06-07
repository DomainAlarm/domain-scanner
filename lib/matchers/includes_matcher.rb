require_relative './matcher'

# Checks if the suspect domain includes the monitored domain
class IncludesMatcher < Matcher

  MATCHER_NAME = 'includes'

  # @see Matcher.get_match_result
  # @todo Need to support multiple substring matches, right now only shows the first hit
  def self.get_match_result(monitored_domain, suspect_domain)
    substring_index = suspect_domain.downcase.index(monitored_domain.downcase)
    if substring_index
      MatchResult.new(monitored_domain, suspect_domain, MATCHER_NAME,
                      [Range.new(substring_index, substring_index + monitored_domain.size)])
    else
      nil
    end
  end

  MatcherManager.register(MATCHER_NAME, self)
end