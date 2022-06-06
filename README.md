# DomainAlarm's Zone File Phishing/Lookalike Scanner
This tool scans zone files (preferably from ICANN's Centralized Zone Data Service)
and finds potential lookalike/phishing domains for your watch term(s).

## Basic Use
To use the tool, you'll need Ruby/Bundler (should be installed with most distros) and the following:
1. A directory of DNS Zone Files
2. A watch term or a rule file
3. (Optional) An output format you want to use

The syntax for the tool is:
```bash
ruby scanner.rb --zone_file_directory=/path/to/zone/files/ --rule_file_location=/path/to/rule_file.json
```

That invocation will scan every zone file in the zone file directory and look for any matches against
the watch terms in the rules file. If you don't want to specify a rules file, simply include a watch
term as the last argument at the command line: 
```bash
ruby scanner.rb --zone_file_directory=/path/to/zone/files/ watch_term
```

## Rule File Format
The rule file is a simple JSON file with an array of rules:
```json
{
  "rules" : [
    {"watch_term" : "watch_term", "ignored_detections" : []},
    {"watch_term" : "example", "ignored_detections" : ["similar"]}
  ]
}
```
As you can see, each rule has a watch term and a list of detections to ignore for that term. Some terms
can be noisy for certain detections (very short terms can trigger the "similar" detection very often,
for example).

## Extending the matching system
The code is designed to be extended if you have custom matching logic you want to add/create. To do so,
copy an existing matcher (lib/matchers/exact_matcher.rb is one of the simplest ones) and write your own
implementation of the `get_match_result` method. Make sure to also set the value of `MATCHER_NAME` to be
something that makes sense for your matcher. For example, if you wanted to match on all domain names that
matched a certain regex you might write:

```ruby
def self.get_match_result(monitored_domain, suspect_domain)
    if suspect_domain.downcase =~ /regex to match/
      MatchResult.new(monitored_domain, suspect_domain, MATCHER_NAME, [])
    else
      nil
    end
end
```

## How to get zone files
Zone files can be retrieved from ICANN's CZDS

## Running in Docker
TODO