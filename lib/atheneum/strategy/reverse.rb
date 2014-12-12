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

      def stored_attribute(attribute)
        "#{prefix}_#{attribute}"
      end
    end
  end
end