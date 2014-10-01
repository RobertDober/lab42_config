require_relative 'config/class_methods'

module Lab42
  module Config

    def self.included into
      into.extend ClassMethods
    end
    def configuration
    end
    
  end # module Config
end # module Lab42
