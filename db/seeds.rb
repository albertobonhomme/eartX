# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Product.destroy_all 
Category.destroy_all
Comment.destroy_all

paul, alia, leto, perez, alberto = User.create([
  {name: 'Paul Atreides',  email: 'paul@arrakis.com', password: 'ironhack', password_confirmation: 'ironhack'},
  {name: 'Alia Atreides',  email: 'alia@arrakis.com',  password: 'ironhack', password_confirmation: 'ironhack'},
  {name: 'Leto Atreides', email: 'leto@arrakis.com',  password: 'ironhack', password_confirmation: 'ironhack'},
  {name: 'Perez Atreides', email: 'luta@arrakis.com',  password: 'ironhack', password_confirmation: 'ironhack'},
  {name: 'Alberto Bonhomme', email: 'albertobonhomme@gmail.com',  password: 'Angrybirds11', password_confirmation: 'Angrybirds11'}
])


pantalones = Category.create(name: "Pantalones")
calzado = Category.create(name: "Calzado")
jerseis = Category.create(name: "Jerseis")
deporte = Category.create(name: "Ropa deportiva")
jeans = Category.create(name: "Jeans")
shorts = Category.create(name: "Shorts")
faldas = Category.create(name: "Faldas")
camisetas = Category.create(name: "Camisetas")
camisas = Category.create(name: "Camisas")
vestidos = Category.create(name: "Vestidos")
monos = Category.create(name: "Monos")


nuevocon = Condition.create(name: "Nuevo con etiqueta")
nuevosin = Condition.create(name: "Nuevo sin etiqueta")
usado = Condition.create(name: "Usado")

woman = Gender.create(name: "Woman")
man = Gender.create(name: "Man")
unisex = Gender.create(name: "Unisex")

User.all.each do |user|

	user.products.create(gender_id: woman.id , condition_id: usado.id, size: "S" , category_id: faldas.id, price: rand(5..20), name: "Falda", brand: "Primark", image: "http://www.eleganceforme.com/wp-content/uploads/2013/06/primark2.jpg", description: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...")
	user.products.create(gender_id: woman.id , condition_id: nuevosin.id, size: "M" , category_id: camisas.id, price: rand(5..20), name: "Blusa", brand: "Bershka", image: "http://g03.a.alicdn.com/kf/HTB1fn6vIpXXXXcxXVXXq6xXFXXXW/Mujeres-Tops-amarillo-blusa-de-la-gasa-Blusas-camisa-Feminina-mujer-camisas-del-estilo-del-verano.jpg", description: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...")
	user.products.create(gender_id: man.id , condition_id: nuevocon.id, size: "S" , category_id: camisas.id, price: rand(5..20), name: "Camisa", brand: "Massimo Dutti", image: "http://yohombre.com/wp-content/uploads/2012/05/camisa-massimo-dutti-rosa-197x300.jpg", description: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...")
	user.products.create(gender_id: woman.id , condition_id: nuevocon.id, size: "L" , category_id: camisetas.id, price: rand(5..20), name: "Camiseta", brand: "Zara", image: "http://www.complementosmoda.es/wp-content/uploads/2010/03/camiseta-zara-lazos.jpg", description: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...")
	user.products.create(gender_id: unisex.id , condition_id: usado.id, size: "40" , category_id: calzado.id, price: rand(5..20), name: "Zapatillas", brand: "New Balance", image: "http://www.nbmadridbaratas.es/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/n/b/nb574-001_01.jpg", description: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...")

	Product.all.each do |product|

	product.comments.create(user_id: user.id, content: Faker::Commerce.department)

	end
end


