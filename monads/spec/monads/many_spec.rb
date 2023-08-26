require "monads/many"

module Monads
    RSpec.describe "the Many monad" do
        let(:values) { double }
        let(:many) { Many.new(values) }

        describe "#values" do
            it "retrieves the values from a Many" do
               expect(many.values).to eq values
            end
        end

        describe "#and_then" do
            context "when there aren't any values" do
                let(:values) { [] }

                it "does not call the block" do
                    expect { |block| many.and_then(&block) }.not_to yield_control
                end
            end

            context "when there are values" do
                let(:values) { [1, 2, 3] }

                it "calls the block with each value" do
                    expect(Many.new(values).and_then { |value| Many.new(value * 2) }.values ).to eq [2, 4, 6]
                end

                it "raises an error if the block does not return a Many" do
                    expect{Many.new(values).and_then { |value| value * 2 }.values }.to raise_error(TypeError)
                end
            end
        end
    end
end