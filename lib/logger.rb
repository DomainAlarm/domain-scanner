# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

class Logger

  OUTPUT_LOGS = false

  def self.log(message)
    STDERR.puts(message) if OUTPUT_LOGS
  end

end