require "atheneum/version"
require "atheneum/errors"
require "atheneum/strategy"
require "atheneum/storage"

module Atheneum
  def self.method_missing(strategy, *attributes, &block)
    options = attributes.pop if attributes.last.class == Hash
    options ||= {}
    Storage.generate strategy, attributes, options
  end
end
