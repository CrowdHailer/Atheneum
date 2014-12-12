require_relative './strategy/reverse'
require_relative './strategy/upper_case'
require_relative './strategy/crypt'

module Atheneum
  class Strategy
    def self.find(name)
      nodule = constantize(name)
      begin
        const_get(nodule)
      rescue NameError
        raise StrategyUndefined.new "Strategy \"#{nodule}\" not found"
      end
    end

    def self.constantize(string)
      string.to_s.split('_').map(&:capitalize).join
    end

  end
end