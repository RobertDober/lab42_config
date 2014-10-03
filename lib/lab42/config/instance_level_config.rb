require 'forwarder'

module Lab42
  module Config

    class InstanceLevelConfig < BasicObject

      private
      def initialize values, receiver
        @values = values
        @receiver = receiver
      end

      def method_missing name, *args, &blk
        super unless args.empty? && blk.!
        @values.get_with_context name, @receiver
      end

    end # class Instance
  end # module Config
end # module Lab42
