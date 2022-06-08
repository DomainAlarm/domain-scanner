# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require "zlib"

require_relative "lib/logger"
require_relative "lib/matchers/matcher_manager"
require_relative "lib/options_parser"
require_relative "lib/rule_file"
require_relative "lib/zone_file_parser"

MatcherManager.load_all_matchers

# Parse the command line
OptionsParser.parse(["--help"]) if ARGV.empty?
options = OptionsParser.parse(ARGV)

specific_watch_term = ARGV.pop
zone_file_dir = (options.zone_file_directory || "")
rule_file_path = (options.rule_file_location || "")
output_format = options.output_format || "json"

rule_file = nil

if specific_watch_term
  rule_file = RuleFile.new([RuleFileEntry.new(specific_watch_term, [])])
elsif File.exist?(rule_file_path)
  rule_file = RuleFile.new_from_json(rule_file_path)
else
  puts "Error: must specify a specific watch term or a rule file"
  exit 1
end

if rule_file.rules.empty?
  puts "Error: Rules in rules file were empty"
  exit 1
end

unless File.directory?(zone_file_dir)
  puts "Error: the zone file directory is invalid. The path must point to a directory of zone files"
  puts "Provided: #{zone_file_dir}"
  exit 1
end

valid_output_formats = ["csv", "tsv", "json"]
unless valid_output_formats.include?(output_format)
  puts "Error: Output format invalid, must specify one of #{valid_output_formats.join(", ")}"
  exit 1
end

hits = []

# Scan the zone files specified
Dir.glob(File.join(zone_file_dir, "*")).each do |zone_file_path|
  file_name = File.basename(zone_file_path)
  tld = file_name.split(".").first
  mime_type = `file -b --mime #{zone_file_path}`.chomp

  # Check if it's a gz or straight text and use the appropriate reader
  f = nil
  if mime_type.start_with?("application/gzip")
    f = Zlib::GzipReader.open(zone_file_path)
  else
    f = File.open(zone_file_path, "r")
  end

  last_entry = nil
  f.each_line do |line|
    entry = ZoneFileParser.parse_line(line)
    next if entry.nil? || entry == last_entry
    #Logger.log("Checking #{entry}")
    rule_file.rules.each do |rule|
      result = MatcherManager.get_match_results(rule.watch_term, entry, rule.ignored_detections)
      result.map! {|x| x.matched_domain += ".#{tld}"; x}
      hits += result
    end
    last_entry = entry
  end

  f.close
end

# Collect the results and output using the specified format
hits.each do |hit|
  if output_format == "json"
    puts hit.to_json
  elsif output_format == "tsv"
  elsif output_format == "csv"
  end
end