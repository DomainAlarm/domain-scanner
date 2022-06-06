require "optparse"

Options = Struct.new(:rule_file_location, :zone_file_directory, :output_format)

class OptionsParser
  def self.parse(options)
    args = Options.new()

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Scans DNS zone files for lookalike and phishing domains\n" +
        "Usage: ruby scanner.rb [options] <specific watch term>\n" +
        "Note: watch term should not be a FQDN, it should be the second level domain only\n" +
        "  for example, don't use 'example.com' and instead use 'example'"

      opts.on("-r RULE_FILE_LOCATION", "--rule_file_location=RULE_FILE_LOCATION", "The location of the rule file (.json)") do |n|
        args.rule_file_location = n
      end

      opts.on("-z ZONE_FILE_DIRECTORY", "--zone_file_directory=ZONE_FILE_DIRECTORY", "The location of the zone files") do |n|
        args.zone_file_directory = n
      end

      opts.on("-f OUTPUT_FORMAT", "--output_format=OUTPUT_FORMAT", "The output format to use (supports csv, tsv, and json)") do |n|
        args.output_format = n
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end