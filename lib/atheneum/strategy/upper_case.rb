module Atheneum
  class Strategy
    class Reverse
      def pack(item)
        item.reverse
      end

      def unpack(item)
        item.reverse
      end

      def prefix
        "reversed"
      end
    end
  end
end