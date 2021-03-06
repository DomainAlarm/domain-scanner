# Copyright 2022-Present Intuitive Analytics Inc. DBA DomainAlarm
# https://domainalarm.net | contact@domainalarm.net
# This code is distributed under the GPL v3 License. Please see the LICENSE file
# in the source repository for more information.

require "json"

class RuleFile

  attr_accessor :rules

  def initialize(rules=[])
    @rules = rules
  end

  def self.new_from_json(path)
    data = JSON.parse(IO.read(path))
    RuleFile.new(data["rules"].map {|x| RuleFileEntry.new_from_hash(x)})
  end

end

class RuleFileEntry

  attr_reader :watch_term, :ignored_detections

  def initialize(watch_term, ignored_detections)
    @watch_term = watch_term
    @ignored_detections = ignored_detections
  end

  def self.new_from_hash(hash)
    RuleFileEntry.new(hash["watch_term"], hash["ignored_detections"])
  end
end