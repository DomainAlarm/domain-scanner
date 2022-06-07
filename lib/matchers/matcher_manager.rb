require_relative '../logger'
# Class that manages all of the matchers
class MatcherManager

  # The list of matchers registered
  @@matchers = {}

  # Registers a matcher with the manager
  # @param [String] name The name of the matcher
  # @param [Class] klass The Matcher class
  def self.register(name, klass)
    @@matchers[name] = klass
  end

  # Returns the list of matchers
  # @return [Hash<String, Class>] The matchers
  def self.matchers
    @@matchers
  end

  # Scans all matchers for a match
  # @param [String] monitored_domain The domain being monitored
  # @param [String] suspect_domain The domain being checked
  # @param [Array<String>] matchers_to_ignore A list of matchers to ignore for this scan
  # @return [Array<MatchResult>] The match results
  def self.get_match_results(monitored_domain, suspect_domain, matchers_to_ignore=[])
    hits = []
    @@matchers.each do |name, klass|
      next if matchers_to_ignore.include?(name)
      result = klass.get_match_result(monitored_domain, suspect_domain)
      hits.push(result) if result
    end
    hits
  end

  def self.load_all_matchers
    # Require all *_matcher.rb files in this directory automatically
    Dir.glob(File.join(File.dirname(__FILE__), "*_matcher.rb")).each do |x|
      Logger.log("Adding #{x} to MatcherManager")
      require x
    end
  end

end
