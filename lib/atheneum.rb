require "atheneum/version"
require "atheneum/errors"

module Atheneum
  class Strategy
    module Reverse
      def password=(password)
        self.reversed_password = password.reverse
      end

      def password
        reversed_password.reverse
      end
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
            self.send "reversed_#{record}=", item.reverse
          }

          define_method record, -> (){
            self.send("reversed_#{record}").reverse
          }
        end
      end
    end
  end
end

module Atheneum
  def self.method_missing(method_name, *arguments, &block)
    begin
      strategy = Strategy.const_get method_name.capitalize
    rescue NameError
      raise StrategyUndefined.new "Strategy \"#{method_name}\" not found"
    end
    storage = Storage.new strategy
    storage.for arguments
  end
end
