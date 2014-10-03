require_relative 'class_level_config'

module Lab42
  module Config
    module ClassMethods
      def config &blk
        __config__.instance_exec &blk
      end
      def __config__
        @__config__ ||= Lab42::Config::ClassLevelConfig.new
      end

      def instance_config *names
        names.each do | name |
          ivar_name = "@__lab42_config_local__#{name}__"
          # define getter
          define_method name do
            instance_variable_defined?( ivar_name ) ?
              instance_variable_get( ivar_name ) :
              instance_variable_set( ivar_name, configuration.__send__( name ) )
          end
          # define setter
          define_method "#{name}=" do |val|
              instance_variable_set( ivar_name, val )
          end

        end
      end
    end # module ClassMethods
  end # module Config
end # module Lab42
