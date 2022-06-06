class Logger

  OUTPUT_LOGS = false

  def self.log(message)
    STDERR.puts(message) if OUTPUT_LOGS
  end

end