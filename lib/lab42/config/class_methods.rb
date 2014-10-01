require_relative 'instance'

module Lab42
  module Config
    module ClassMethods
      def config &blk
        __config__.instance_exec &blk
        __config__.freeze!
      end
      def __config__
        @__config__ ||= Lab42::Config::Instance.new
      end
    end # module ClassMethods
  end # module Config
end # module Lab42
