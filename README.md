# DomainAlarm's Zone File Phishing/Lookalike Scanner
This tool scans zone files (preferably from ICANN's Centralized Zone Data Service)
and finds potential lookalike/phishing domains for your watch term(s). This tool is distributed by
DomainAlarm (https://domainalarm.net) for the benefit of the public and is subject to the GPL v3
License. For help or questions, please email contact@domainalarm.net

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

## Setup
1. Start with a unix system with ruby and git installed
2. Clone this repo: `git clone https://github.com/DomainAlarm/domain-scanner.git`
3. Install bundler: `sudo gem install bundler`
4. Install ruby dev tools: `sudo apt-get install ruby ruby-all-dev`
5. Install rest of gems: `bundle install`
6. Ensure you have the "file" command: `sudo apt install file`

## Example Data
We include some example data. To try it out, run:
```bash
ruby scanner.rb --zone_file_directory=tests/sample_data test
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
Also don't forget to change the name of the class! We have logic that will automatically load your new
matcher if you name the file <your_name>_matcher.rb and stick it in lib/matchers/

## How to get zone files
Zone files can be retrieved from ICANN's CZDS: https://czds.icann.org/help#zone-files

## Running in Docker
The project comes with a Dockerfile for simple cross-platform execution. To build the image:
```bash
docker build -t domain-scanner .
```

From there, you can run the tool by mapping in a directory of zone files:
```bash
docker run -it -v /path/to/zone/files/:/opt/zone_files/ domain-scanner ruby /opt/domain-scanner/scanner.rb -z /opt/zone_files/ search_term
```