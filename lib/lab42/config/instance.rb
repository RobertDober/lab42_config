module Lab42
  module Config
    class Instance < BasicObject

      private
      def method_missing name, *args, &blk
        super if args.size > 1
        return __values__.fetch( name ){ super } if args.empty? && blk.!

        __values__[ name ] = args.first || instance_exec(&blk) 
      end

      def __values__
        @__values__ ||= {}
      end
      

    end # class Instance
  end # module Config
end # module Lab42
