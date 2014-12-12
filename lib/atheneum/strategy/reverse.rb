module Atheneum
  class Strategy
    class UpperCase
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
  end
end