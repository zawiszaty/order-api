# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.destroy_all

10.times do
  product =  Product.new(
    name: "Product 1",
    price: 100,
    description: "Product 1 description",
    )
  product.thumbnail.attach(
    io: File.open(Rails.root.join("spec", "fixtures", "thumbnail.jpg")),
    filename: "thumbnail.jpg",
    )
  product.save
end

order = Order.new()
order.save

order_product = OrderProducts.new(
  order: order,
  product: Product.first,
  amount: 1,
  )

order_product.save