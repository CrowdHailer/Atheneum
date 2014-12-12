module Atheneum
  class Strategy
    class Base
      def initialize(options)
        @options = options
      end

      attr_reader :options

      def stored_attribute(attribute)
        "#{prefix}_#{attribute}"
      end

      def prefix
        options.fetch(:prefix){
          self.class.name.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join('_')+'d'
        }
      end

      def privatise?
        options.fetch(:privatise) { true }
      end
    end
  end
end