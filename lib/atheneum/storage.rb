module Atheneum

  class Storage
    def initialize(strategy)
      @strategy = strategy
    end

    attr_reader :strategy

    def for(records)
      make_module(records, strategy)
    end

    def make_module(records, strategy)
      Module.new do
        records.each do |record|
          define_method "#{record}=", ->(item){
            self.send "#{strategy.store_for(record)}=", strategy.pack(item)
          }

          define_method record, -> (){
            strategy.unpack(self.send("#{strategy.store_for(record)}"))
          }
        end

        if strategy.privatise?
          define_singleton_method :'included', ->(klass){
            records.each do |record|
              klass.send :private, strategy.store_for(record)
              klass.send :private, "#{strategy.store_for(record)}="
            end
          }
        end

      end
    end

    def self.generate strategy_name, attributes, options
      strategy = Strategy.find strategy_name
      storage = new strategy.new(options)
      storage.for attributes
    end
  end
end