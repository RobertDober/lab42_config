require_relative 'config/class_methods'
require_relative 'config/class_level_config'

module Lab42
  module Config

    def self.included into
      into.extend ClassMethods
    end
    def configuration
      @_lab42_config__configuration__ = self.class.__config__.instance_level_config self
    end
    
  end # module Config
end # module Lab42
