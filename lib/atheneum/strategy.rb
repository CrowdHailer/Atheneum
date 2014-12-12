require_relative './strategy/reverse'
require_relative './strategy/upper_case'

module Atheneum
  class Strategy
    def self.find(name)
      nodule = constantize(name)
      begin
        const_get(nodule).new
      rescue NameError
        raise StrategyUndefined.new "Strategy \"#{nodule}\" not found"
      end
    end

    def self.constantize(string)
      string.to_s.split('_').map(&:capitalize).join
    end

  end
end