module Atheneum
  class Strategy
    class Crypt < Base
      def pack(string)
        BCrypt::Password.create(string).to_s
      end

      def unpack(crypted_record)
        BCrypt::Password.new(crypted_record)
      end
    end
  end
end