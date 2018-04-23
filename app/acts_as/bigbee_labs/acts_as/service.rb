module BigbeeLabs::ActsAs::Service

  attr_accessor *%w(
    args
  ).freeze

  module ClassMethods

    def call(args={})
      new(args).call 
    end

    def use_peer_service_for *args
      class_eval do 
        args.each do |method_sym|
          define_method(method_sym) do |args={}| 
            call_peer_service(method_sym, args)
          end
        end
      end
    end
    
  end
  
  module InstanceMethods

    def initialize(args={})
      @args = args.with_indifferent_access
      assign_args
    end

    def call
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
    end

  private

    def assign_args
      args.each do |k,v| 
        class_eval do 
          attr_accessor k
        end
        send("#{k}=",v)
      end
    end

    def good_to_go?
      required_arguments_present? && required_values_present?
    end

    def required_arguments_present?
      if defined?(self.class::REQUIRED_ARGS)
        begin
          self.class::REQUIRED_ARGS.each do |arg_sym|
            raise ActsAsRelatingTo::RequiredArgumentMissingError, arg_sym unless self.respond_to?(arg_sym)
          end
        rescue ActsAsRelatingTo::RequiredArgumentMissingError => e
          @error = e
          record_error missing_argument: e.message
          return false
        end
        return true
      else
        return true 
      end
    end

    def required_values_present?
      if defined?(self.class::REQUIRED_VALUES)
        begin
          self.class::REQUIRED_VALUES.each do |value_sym|
            if args.is_a?(DecoratorBase)
              raise ActsAsRelatingTo::RequiredValueMissingError, value_sym if args.send(value_sym).nil?
            else
              raise ActsAsRelatingTo::RequiredValueMissingError, value_sym if send(value_sym).nil?
            end
          end
        rescue ActsAsRelatingTo::RequiredValueMissingError => e 
          puts "#{self.class}.#{__method__}, e.message:"<<" #{e.message}".blue
          @error = e
          record_error missing_value: e.message
          return false
        rescue NoMethodError => e 
          puts "#{self.class}.#{__method__}, e.message:"<<" #{e.message}".blue
          @error = e
          record_error missing_method: e.name
          return false
        end
        return true
      else
        return true 
      end
    end

    def record_error(added_details={})
      puts "#{self.class}.#{__method__}, added_details:"<<" #{added_details}".red
    end

    def decorated_args; @decorated_args ||= get_decorated_args end
    
    def get_decorated_args
      class_name_split.send(:<<, 'ArgsDecorator').join('::').constantize.new(args)
    end  

    def class_name_split
      self.class.name.split('::')
    end

    def peer_service(called_by=nil)
      called_by ||= caller_locations.first.label.camelize
      service_name = called_by.to_s.camelize
      class_name_split.tap do |name_ary|
        name_ary.pop 
        return name_ary.send(:<<, "#{service_name}Service").join('::').constantize
      end
    end

    def call_peer_service(service_name=nil,args={})
      service_name ||= caller_locations.first.label
      call_service(peer_service(service_name),args)
    end    

  end
  
  def self.included(receiver)
    receiver.extend  ClassMethods
    receiver.include InstanceMethods
  end
end