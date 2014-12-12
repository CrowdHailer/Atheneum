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
            self.send "#{strategy.prefix}_#{record}=", strategy.pack(item)
          }

          define_method record, -> (){
            strategy.unpack(self.send("#{strategy.prefix}_#{record}"))
          }
        end
      end
    end
  end
end

module Atheneum
  def self.method_missing(method_name, *arguments, &block)
    strategy = Strategy.find method_name
    
    storage = Storage.new strategy
    storage.for arguments
  end
end
