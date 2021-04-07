# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Video.create(title: "Star Wars", description: "Battles in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Wars", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Wars")
Video.create(title: "Lord of the Rings", description: "Fantasy about rings", small_cover_url: "https://via.placeholder.com/200x300.png?text=Lord+of+the+Rings", large_cover_url: "https://via.placeholder.com/500x350.png?text=Lord+of+the+Rings")
Video.create(title: "Futurama", description: "Futuristic cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Futurama", large_cover_url: "https://via.placeholder.com/500x350.png?text=Futurama")
Video.create(title: "Rick And Morty", description: "Funny cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Rick+and+Morty", large_cover_url: "https://via.placeholder.com/500x350.png?text=Rick+and+Morty")