module Atheneum
  class Strategy
    class Base
      def stored_attribute(attribute)
        "#{prefix}_#{attribute}"
      end

      def prefix
        self.class.name.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join('_')+'d'
      end
    end
  end
end