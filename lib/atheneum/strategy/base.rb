module Atheneum
  class Strategy
    class Base
      def initialize(options)
        @options = options
      end

      def stored_attribute(attribute)
        "#{prefix}_#{attribute}"
      end

      def prefix
        self.class.name.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join('_')+'d'
      end

      def privatise?
        @options.fetch(:privatise) { true }
      end
    end
  end
end