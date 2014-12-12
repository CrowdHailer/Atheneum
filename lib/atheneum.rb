require "atheneum/version"
require "atheneum/errors"
require "atheneum/strategy"

module Atheneum

  class Storage
    def initialize(strategy)
      @strategy = strategy
    end

    attr_reader :strategy

    def for(records)
      make_module(records, strategy)
    end

    def make_module(records, strategy)
      Module.new do
        records.each do |record|
          define_method "#{record}=", ->(item){
            self.send "#{strategy.stored_attribute(record)}=", strategy.pack(item)
          }

          define_method record, -> (){
            strategy.unpack(self.send("#{strategy.stored_attribute(record)}"))
          }
        end
      end
    end

    def self.generate strategy_name, attributes
      strategy = Strategy.find strategy_name
      storage = new strategy
      storage.for attributes
    end
  end
end

module Atheneum
  def self.method_missing(strategy, *attributes, &block)
    Storage.generate strategy, attributes
  end
end
