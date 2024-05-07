require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do 
      @cat1 = Category.find_or_create_by! name: 'Evergreens'
    end

    it "is valid with all fields set" do
      @product1 = @cat1.products.build(
        name: "Product",
        description: "Description",
        image: "image.jpg",
        quantity: 5,
        price: 10.99
      )
      @product1.save
      expect(@product1).to be_valid
    end

    it "is invalid without a name" do
      @product2 = @cat1.products.build(
        name: nil,
        description: "Description",
        image: "image.jpg",
        quantity: 5,
        price: 10.99
      )
      @product2.save
      expect(@product2.errors.full_messages).to include("Name can't be blank")
    end

    it "is invalid without a price" do
      @product3 = @cat1.products.build(
        name: "Product",
        description: "Description",
        image: "image.jpg",
        quantity: 5,
        price: "nil"
      )
      @product3.save
      expect(@product3.errors.full_messages).to include("Price is not a number")
    end

    it "is invalid without a quantity" do
      @product4 = @cat1.products.build(
        name: "Product",
        description: "Description",
        image: "image.jpg",
        quantity: nil,
        price: 10.99
      )
      @product4.save
      expect(@product4.errors.full_messages).to include("Quantity can't be blank")
    end

    it "is invalid without a category" do
      @product5 = Product.new(
        name: "Product",
        description: "Description",
        image: "image.jpg",
        quantity: 5,
        price: 10.99
      )
      @product5.save
      expect(@product5.errors.full_messages).to include("Category can't be blank")
    end
  end
end