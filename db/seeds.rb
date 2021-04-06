# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Video.create(title: "Star Wars", description: "Battles in space", small_cover_url: "https://via.placeholder.com/200x300.png", large_cover_url: "https://via.placeholder.com/500x350.png")
Video.create(title: "Lord of the Rings", description: "Fantasy about rings", small_cover_url: "https://via.placeholder.com/200x300.png", large_cover_url: "https://via.placeholder.com/500x350.png")
Video.create(title: "Futurama", description: "Futuristic cartoon", small_cover_url: "https://via.placeholder.com/200x300.png", large_cover_url: "https://via.placeholder.com/500x350.png")
Video.create(title: "Rick And Morty", description: "Funny cartoon", small_cover_url: "https://via.placeholder.com/200x300.png", large_cover_url: "https://via.placeholder.com/500x350.png")