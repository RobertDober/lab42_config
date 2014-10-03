require_relative 'instance_level_config'

require 'forwarder'

module Lab42
  module Config
    Lazy = Struct.new :behavior do
      def to_proc; behavior end
    end

    class Values
      extend Forwarder
      forward_all :[], :[]=, :fetch, to: :__values__

      def get_with_context key, rcv
        val = fetch( key ){ raise NoMethodError, "undefined method `#{key}'" }
        if Lazy === val
          rcv.instance_exec &val
        else
          val
        end
      end

      private
      def __values__
        @__values__ ||= {}
      end
    end

    class ClassLevelConfig < BasicObject

      def instance_level_config rcv
        InstanceLevelConfig.new __values__, rcv
      end


      private
      def method_missing name, *args, &blk
        super if args.size > 1 || ( args.empty? && blk.! )

        __values__[ name ] = args.first || Lazy.new( blk )
      end

      def __values__
        @__values__ ||= Values.new
      end


    end # class Instance
  end # module Config
end # module Lab42
