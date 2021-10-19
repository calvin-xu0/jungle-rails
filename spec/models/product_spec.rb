require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new
    @product = Product.new(name: "Snake Oil Cabinet", price: 99.99, quantity: 9, category: @category)
  end

  describe 'Validations' do
    it "should be valid with all four fields" do
      expect(@product).to be_valid
    end
    it "should not be valid without a name" do
      @product.name = nil
      expect(@product).to_not be_valid
      puts @product.errors.full_messages
    end
    it "should not be valid without a price" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      puts @product.errors.full_messages
    end
    it "should not be valid without a quantity" do
      @product.quantity = nil
      expect(@product).to_not be_valid
      puts @product.errors.full_messages
    end
    it "should not be valid without a category" do
      @product.category = nil
      expect(@product).to_not be_valid
      puts @product.errors.full_messages
    end
  end
end
