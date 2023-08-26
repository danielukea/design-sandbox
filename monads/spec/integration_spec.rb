require "monads"

module Monads
  RSpec.describe "Chaining monads" do
      describe "Optional" do

        it "should be able to chain" do
          Project = Struct.new(:creator)
          Person = Struct.new(:address)
          Address = Struct.new(:country)
          Country = Struct.new(:capital)
          City = Struct.new(:weather)

          result = double
          project = Project.new(Person.new(Address.new(Country.new(City.new(result)))))

          expect(project.creator.address.country.capital.weather).to be result

          project = Project.new(nil)

          expect(Optional.new(project).creator.address.country.capital.weather.value).to be nil
        end
      end
  end
end