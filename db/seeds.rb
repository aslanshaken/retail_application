# db/seeds.rb

# Clear existing products
Product.destroy_all

# Seed data for products
Product.create(name: "Product 1", price: 19.99, status: "active")
Product.create(name: "Product 2", price: 29.99, status: "active")
Product.create(name: "Product 3", price: 2.49, status: "active")


