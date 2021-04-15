# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cartoons = Category.create(name: "Cartoons")
sci_fi = Category.create(name: "Sci-fi")
fantasy = Category.create(name: "Fantasy")

sci_fi.videos << Video.create(title: "Star Wars", description: "Battles in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Wars", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Wars")
sci_fi.videos << Video.create(title: "Star Trek", description: "Voyages in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Trek", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Trek")
sci_fi.videos << Video.create(title: "Ender's Game", description: "Battles with aliens", small_cover_url: "https://via.placeholder.com/200x300.png?text=Enders+Game", large_cover_url: "https://via.placeholder.com/500x350.png?text=Enders+Game")
sci_fi.videos << Video.create(title: "Interstellar", description: "Humans in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Interstellar", large_cover_url: "https://via.placeholder.com/500x350.png?text=Interstellar")
fantasy.videos << Video.create(title: "Lord of the Rings", description: "Fantasy about rings", small_cover_url: "https://via.placeholder.com/200x300.png?text=Lord+of+the+Rings", large_cover_url: "https://via.placeholder.com/500x350.png?text=Lord+of+the+Rings")
fantasy.videos << Video.create(title: "Harry Potter", description: "Magical humans", small_cover_url: "https://via.placeholder.com/200x300.png?text=Harry+Potter", large_cover_url: "https://via.placeholder.com/500x350.png?text=Harry+Potter")
fantasy.videos << Video.create(title: "Inkheart", description: "Humans and dragons", small_cover_url: "https://via.placeholder.com/200x300.png?text=Inkheart", large_cover_url: "https://via.placeholder.com/500x350.png?text=Inkheart")
fantasy.videos << Video.create(title: "Eragon", description: "Dragons and magic", small_cover_url: "https://via.placeholder.com/200x300.png?text=Eragon", large_cover_url: "https://via.placeholder.com/500x350.png?text=Eragon")
fantasy.videos << Video.create(title: "His Dark Materials", description: "Allegorical fantasy", small_cover_url: "https://via.placeholder.com/200x300.png?text=His+Dark+Materials", large_cover_url: "https://via.placeholder.com/500x350.png?text=His+Dark+Materials")
fantasy.videos << Video.create(title: "The Chronicles of Narnia", description: "Allegorical fantasy", small_cover_url: "https://via.placeholder.com/200x300.png?text=The+Chronicles+of+Narnia", large_cover_url: "https://via.placeholder.com/500x350.png?text=The+Chronicles+of+Narnia")
fantasy.videos << Video.create(title: "The Wizard of Oz", description: "Wizards not in Kansas", small_cover_url: "https://via.placeholder.com/200x300.png?text=The+Wizard+of+Oz", large_cover_url: "https://via.placeholder.com/500x350.png?text=The+Wizard+of+Oz")
cartoons.videos << Video.create(title: "Futurama", description: "Futuristic cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Futurama", large_cover_url: "https://via.placeholder.com/500x350.png?text=Futurama")
cartoons.videos << Video.create(title: "Rick And Morty", description: "Funny cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Rick+and+Morty", large_cover_url: "https://via.placeholder.com/500x350.png?text=Rick+and+Morty")
cartoons.videos << Video.create(title: "Scooby Doo", description: "Mystery solving dog", small_cover_url: "https://via.placeholder.com/200x300.png?text=Scooby+Doo", large_cover_url: "https://via.placeholder.com/500x350.png?text=Scooby+Doo")