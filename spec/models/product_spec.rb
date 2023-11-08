require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'Example Category')
      @product = Product.new(
        name: 'Example Product',
        price_cents: 1000, # Assuming the price is in cents
        quantity: 5,
        category: @category
      )
    end

    it 'saves successfully when all fields are set' do
      expect(@product).to be_valid
      @product.save
      expect(Product.count).to eq(1)
    end

    it 'is not valid without a name' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'is not valid without a quantity' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

