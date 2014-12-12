require "atheneum/version"
require "atheneum/errors"

module Atheneum
  def self.method_missing(method_name, *arguments, &block)
    raise StrategyUndefined.new "Strategy \"#{method_name}\" not found"
  end
end
