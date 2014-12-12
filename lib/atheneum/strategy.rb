require_relative './strategy/reverse'
require_relative './strategy/upper_case'

module Atheneum
  class Strategy
    def self.find(name)
      nodule = constantize(name)
      begin
        new const_get(nodule)
      rescue NameError
        raise StrategyUndefined.new "Strategy \"#{nodule}\" not found"
      end
    end

    def self.constantize(string)
      string.to_s.split('_').map(&:capitalize).join
    end

    def initialize(specific)
      @specific = specific
    end

    def pack(item)
      @specific.pack item
    end

    def unpack(item)
      @specific.unpack item
    end

    def prefix
      @specific.prefix
    end


  end
end