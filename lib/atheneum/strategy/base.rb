module Atheneum
  class Strategy
    class Base < Struct.new(:options)

      def store_for(attribute)
        "#{prefix}_#{attribute}"
      end

      def prefix
        options.fetch(:prefix){
          default_prefix
        }
      end

      def default_prefix
        str = self.class.name.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join('_')
        str[-1, 1] == 'e' ? str + 'd' : str + 'ed'
      end

      def privatise?
        options.fetch(:privatise) { true }
      end
    end
  end
end