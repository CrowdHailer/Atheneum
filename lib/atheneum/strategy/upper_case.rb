require_relative './base'

module Atheneum
  class Strategy
    class Reverse < Base
      def pack(item)
        item.reverse
      end

      def unpack(item)
        item.reverse
      end
    end
  end
end