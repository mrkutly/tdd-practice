require "rspec/autorun"

DimensionalMismatchError = Class.new(StandardError)

Quantity = Struct.new(:amount, :unit)

class UnitConverter
  def initialize(initial_quantity, target_unit)
    @initial_quantity = initial_quantity
    @target_unit = target_unit
  end

  def convert
    Quantity.new(
      @initial_quantity.amount * conversion_factor(from: @initial_quantity.unit, to: @target_unit),
      @target_unit
    )
  end

  private

  CONVERSION_FACTORS = {
    cup: {
      liter: 0.236588
    }
  }

  def conversion_factor(from:, to:)
    CONVERSION_FACTORS[from][to] ||
      raise(DimensionalMismatchError, "Can't convert #{from} to #{to}")
  end
end

describe UnitConverter do
  describe "#convert" do
    it "translates between objects of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :liter)

      result = converter.convert
      expect(result.amount).to be_within(0.001).of(0.473)
      expect(result.unit).to eq(:liter)
    end

    it "can convert between quantities of the same unit" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :cup)

      result = converter.convert
      expect(result.amount).to be_within(0.001).of(2)
      expect(result.unit).to eq(:cup)
    end

    it "raises an error if the two quantities are of differing dimensions" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :gram)

      expect { converter.convert }.to raise_error(DimensionalMismatchError)
    end
  end
end
