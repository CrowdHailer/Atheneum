require "atheneum/version"
require "atheneum/errors"

module Atheneum
  class Strategy
    module Reverse
      def password=(password)
        self.reversed_password = password.reverse
      end
    end
  end
end

module Atheneum
  def self.method_missing(method_name, *arguments, &block)
    begin
      Strategy.const_get method_name.capitalize
    rescue NameError
      raise StrategyUndefined.new "Strategy \"#{method_name}\" not found"
    end
  end
end
