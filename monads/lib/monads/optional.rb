module Monads
    class Optional
        attr_reader :value
        def initialize(value)
          @value = value
        end
    end
end