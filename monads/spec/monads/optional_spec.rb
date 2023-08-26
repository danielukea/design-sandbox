require 'monads/optional'

RSpec.describe Monads::Optional do
    let(:value) { double }
    let(:optional) { described_class.new(value)}

    describe "#value" do
      it "retrives the value from an Optional" do
        expect(optional.value).to eq(value)
      end
    end

    # it should pass the optional value to the block
    describe "#and_then" do
      context "when the value is not nil" do
        it "should pass the optional value to the block" do
          expect { |block| optional.and_then(&block) }.to yield_with_args(value)
        end

        it "returns the blocks result" do
          result = double
          expect(optional.and_then { |value| described_class.new(result) }.value ).to eq result
        end
      end

      context "when the value is nil" do
        before { allow(value).to receive(:nil?).and_return(true) }

        it "does not call the block" do
          expect { |block| optional.and_then(&block) }.not_to yield_control
        end
      end
    end
end