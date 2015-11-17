# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Category.create(name: "Animales y mascotas")
c2 = Category.create(name: "Antigüedades")
c3 = Category.create(name: "Arte y artesanías")
c4 = Category.create(name: "Celulares y teléfonos")
c5 = Category.create(name: "Computación")
c6 = Category.create(name: "Consolas y videojuegos")
c7 = Category.create(name: "Electrodomésticos")
c8 = Category.create(name: "Electrónica y audio")
c9 = Category.create(name: "Hogar")
c10 = Category.create(name: "Instrumentos musicales")
c11 = Category.create(name: "Joyas y relojes")
c12 = Category.create(name: "Libros y revistas")
c13 = Category.create(name: "Ropa y accesorios")
c14 = Category.create(name: "Salud y belleza")
c15 = Category.create(name: "Otros")

comprador1 = User.find_or_create_by(email: "comprador1@mail.com") do |user|
	user.password = "comprador1"
	user.password_confirmation = "comprador1"
	user.created_at = "2015-11-16 15:00:00"
end

admin = User.find_or_create_by(email: "administrador@mail.com") do |user|
	user.password = "password_administrador"
	user.password_confirmation = "password_administrador"
	user.admin = true
	user.created_at = "2015-11-16 15:00:00"
end

emi = User.find_or_create_by(email: "liotta.emiliano@gmail.com") do |user|
	user.admin = true
end