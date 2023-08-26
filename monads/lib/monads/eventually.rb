module Monads
    Eventually = Struct.new(:block) do
        include Monad
        def initialize(&block)
          super(block)
        end

        def run(&success)
          block.call(success)
        end

        def and_then(&block)
            block=ensure_monadic_result(&block)
            Eventually.new do |success|
                run do |value|
                    block.call(value).run(&success)
                end
            end
        end
    end
end