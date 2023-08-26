module Monads
    class Optional
        attr_reader :value
        def initialize(value)
          @value = value
        end

        def method_missing(*args, &block)
            and_then do |value|
              Optional.new(value.public_send(*args, &block))
            end
        end

        def and_then(&block)
          if @value.nil?
            self
          else
            block.call(@value)
          end
        end
    end
end