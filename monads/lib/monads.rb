require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module Monads
end

loader.eager_load