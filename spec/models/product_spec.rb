require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create!(name: "Sweets")
    end

    it "is valid with all fields set" do
      product = Product.new(name: "wine gums", price: 5, quantity: 2, category: @category)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      product = Product.new(price: 4, quantity: 3, category: @category)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a price" do
      product = Product.new(name: "Whittaker's", quantity: 1, category: @category)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is not valid without a quantity" do
      product = Product.new(name: "Whittaker's", price: 7, category: @category)
      product.valid?
      expect(product.errors[:quantity]).to include("can't be blank")
    end

    it "is not valid without a category" do
      product = Product.new(name: "Whittaker's", price: 7, quantity: 6)
      product.valid?
      expect(product.errors[:category]).to include("can't be blank")
    end
  end
end
