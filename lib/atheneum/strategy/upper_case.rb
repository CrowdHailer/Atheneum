module Atheneum
  class Strategy
    module Reverse
      def self.pack(item)
        item.reverse
      end

      def self.unpack(item)
        item.reverse
      end

      def self.prefix
        "reversed"
      end
    end
  end
end