module Atheneum
  class Strategy
    module UpperCase
      def self.pack(item)
        item.upcase
      end

      def self.unpack(item)
        item.downcase
      end

      def self.prefix
        "upper_cased"
      end
    end
  end
end