require 'monads/optional'

RSpec.describe Monads::Optional do
    let(:value) { double }
    let(:optional) { described_class.new(value)}

    describe "#value" do
      it "should retrive the value from an Optional" do
        expect(optional.value).to eq(value)
      end
    end
end