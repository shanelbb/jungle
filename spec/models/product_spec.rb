require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'TestCategory')
    end

    it 'is valid with valid attributes' do
      product = Product.new(
        name: 'TestProduct',
        price_cents: 10000, 
        quantity: 10,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(
        name: nil,
        price_cents: 10000,
        quantity: 10,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      product = Product.new(
        name: 'TestProduct',
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      product.valid?
      puts product.errors.full_messages 
      expect(product.errors.full_messages).to include("Price cents can't be blank")
    end

    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'TestProduct',
        price_cents: 10000,
        quantity: nil,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: 'TestProduct',
        price_cents: 10000,
        quantity: 10,
        category: nil
      )
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
