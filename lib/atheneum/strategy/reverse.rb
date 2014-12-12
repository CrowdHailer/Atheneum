require_relative './base'

module Atheneum
  class Strategy
    class UpperCase < Base
      def pack(item)
        item.upcase
      end

      def unpack(item)
        item.downcase
      end
    end
  end
end