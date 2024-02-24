# db/seeds.rb

Product.destroy_all

10.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..100.0, as_string: false),
    status: ['active', 'inactive'].sample
  )
end

10.times do
  ApprovalQueue.create!(
    product_id: Faker::Number.unique.between(from: 1, to: 20),
    request_date: Faker::Time.backward(days: 30),
    approval_status: ['pending', 'approved', 'rejected'].sample
  )
end
