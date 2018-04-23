class ActsAsRelatingTo::DecoratorBase < SimpleDelegator

  class << self 

    def dig_for(args)
      dig_for_hsh(args, base: true) if args.is_a?(Hash)
      dig_for_ary(args, base: true) if args.is_a?(Array)
    end

  private

    def dig_for_hsh(hsh, options={})
      hsh.each do |k,v|
        if options[:base]
          @dig_ary = [k]
          define_method(k) do 
            component.dig(k)
          end
        else
          raise "Not Implemented!"
        end
        dig_for_hsh(v) if v.is_a?(Hash)
        dig_for_ary(v) if v.is_a?(Array)
      end
    end

    def dig_for_ary(ary, options={})
      ary.each do |attr|
        dig_ary = @dig_ary.clone.send(:<<, attr)
        define_method(dig_ary.join('_')) do 
          component.dig *dig_ary
        end
      end
    end

  end # Class Methods

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def component;        @component ||= get_component  end

  private 

  
    def get_component
      self.__getobj__.tap do |c|
        return c.is_a?(DecoratorBase) ? c.component : c 
      end
    end

    def decorated(objekt)
      "#{objekt.class.name}Decorator".constantize.new(objekt)
    end
 
end