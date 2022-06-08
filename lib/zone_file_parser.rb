# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

class ZoneFileParser

  # @TODO doesn't support zone files that have second level domains acting as top level domains
  def self.parse_line(line)
    return nil if line[0] == ";"
    parts = line.split(/\s+/)
    return nil if parts.length < 3
    return nil if parts[-2] != "NS" && parts[-2] != "ns"
    parts.first.split(".").first
  end

end