require "atheneum/version"
require "atheneum/errors"

module Atheneum
  class Strategy
    module Reverse
      def pack(item)
        item.reverse
      end

      def unpack(item)
        item.reverse
      end

      def prefix
        "reversed"
      end
    end

    module UpperCase
      def pack(item)
        item.upcase
      end

      def unpack(item)
        item.downcase
      end

      def prefix
        "upper_cased"
      end
    end

    def self.find(name)
      nodule = constantize(name)
      begin
        const_get nodule
      rescue NameError
        raise StrategyUndefined.new "Strategy \"#{nodule}\" not found"
      end
    end

    def self.constantize(string)
      string.to_s.split('_').map(&:capitalize).join
    end
  end

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
            self.send "#{prefix}_#{record}=", pack(item)
          }

          define_method record, -> (){
            unpack(self.send("#{prefix}_#{record}"))
          }
        end
      end.include strategy
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
