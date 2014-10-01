require_relative 'config/class_methods'

module Lab42
  module Config

    def self.included into
      into.extend ClassMethods
    end
    def configuration
      self.class.__config__
    end
    
  end # module Config
end # module Lab42
