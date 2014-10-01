require_relative 'instance'

module Lab42
  module Config
    module ClassMethods
      def config &blk
        @__config__ ||= Lab42::Config::Instance.new
        @__config__.instance_exec &blk
      end
    end # module ClassMethods
  end # module Config
end # module Lab42
