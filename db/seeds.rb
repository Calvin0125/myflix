# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

def review_rating
  rand(1..5)
end

def review_body
  Faker::Lorem.words(number: 25).join(" ")
end

cartoons = Category.create(name: "Cartoons")
sci_fi = Category.create(name: "Sci-fi")
fantasy = Category.create(name: "Fantasy")

star_wars = Video.create(title: "Star Wars", description: "Battles in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Wars", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Wars")
star_trek = Video.create(title: "Star Trek", description: "Voyages in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Trek", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Trek")
enders_game = Video.create(title: "Ender's Game", description: "Battles with aliens", small_cover_url: "https://via.placeholder.com/200x300.png?text=Enders+Game", large_cover_url: "https://via.placeholder.com/500x350.png?text=Enders+Game")
interstellar = Video.create(title: "Interstellar", description: "Humans in space", small_cover_url: "https://via.placeholder.com/200x300.png?text=Interstellar", large_cover_url: "https://via.placeholder.com/500x350.png?text=Interstellar")
sci_fi_videos = [star_wars, star_trek, enders_game, interstellar]
sci_fi.videos << sci_fi_videos

lord_of_the_rings = Video.create(title: "Lord of the Rings", description: "Fantasy about rings", small_cover_url: "https://via.placeholder.com/200x300.png?text=Lord+of+the+Rings", large_cover_url: "https://via.placeholder.com/500x350.png?text=Lord+of+the+Rings")
harry_potter = Video.create(title: "Harry Potter", description: "Magical humans", small_cover_url: "https://via.placeholder.com/200x300.png?text=Harry+Potter", large_cover_url: "https://via.placeholder.com/500x350.png?text=Harry+Potter")
inkheart = Video.create(title: "Inkheart", description: "Humans and dragons", small_cover_url: "https://via.placeholder.com/200x300.png?text=Inkheart", large_cover_url: "https://via.placeholder.com/500x350.png?text=Inkheart")
eragon = Video.create(title: "Eragon", description: "Dragons and magic", small_cover_url: "https://via.placeholder.com/200x300.png?text=Eragon", large_cover_url: "https://via.placeholder.com/500x350.png?text=Eragon")
his_dark_materials = Video.create(title: "His Dark Materials", description: "Allegorical fantasy", small_cover_url: "https://via.placeholder.com/200x300.png?text=His+Dark+Materials", large_cover_url: "https://via.placeholder.com/500x350.png?text=His+Dark+Materials")
narnia = Video.create(title: "The Chronicles of Narnia", description: "Allegorical fantasy", small_cover_url: "https://via.placeholder.com/200x300.png?text=The+Chronicles+of+Narnia", large_cover_url: "https://via.placeholder.com/500x350.png?text=The+Chronicles+of+Narnia")
wizard_of_oz = Video.create(title: "The Wizard of Oz", description: "Wizards not in Kansas", small_cover_url: "https://via.placeholder.com/200x300.png?text=The+Wizard+of+Oz", large_cover_url: "https://via.placeholder.com/500x350.png?text=The+Wizard+of+Oz")
fantasy_videos = [lord_of_the_rings, harry_potter, inkheart, eragon, his_dark_materials, narnia, wizard_of_oz]
fantasy.videos << fantasy_videos

futurama = Video.create(title: "Futurama", description: "Futuristic cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Futurama", large_cover_url: "https://via.placeholder.com/500x350.png?text=Futurama")
rick_and_morty = Video.create(title: "Rick And Morty", description: "Funny cartoon", small_cover_url: "https://via.placeholder.com/200x300.png?text=Rick+and+Morty", large_cover_url: "https://via.placeholder.com/500x350.png?text=Rick+and+Morty")
scooby_doo = Video.create(title: "Scooby Doo", description: "Mystery solving dog", small_cover_url: "https://via.placeholder.com/200x300.png?text=Scooby+Doo", large_cover_url: "https://via.placeholder.com/500x350.png?text=Scooby+Doo")
cartoon_videos = [futurama, rick_and_morty, scooby_doo]
cartoons.videos << cartoon_videos

calvin = User.create(full_name: "Calvin Conley", email: "calvin@conley.com", password: "password")
daffy = User.create(full_name: "Daffy Duck", email: "daffy@duck.com", password: "password")
kirby = User.create(full_name: "Kirby", email: "kirby@nintendo.com", password: "password")

sci_fi_videos.each do |video|
  calvin_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << calvin_review
  calvin.reviews << calvin_review
  daffy_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << daffy_review
  daffy.reviews << daffy_review
end

fantasy_videos.each do |video|
  calvin_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << calvin_review
  calvin.reviews << calvin_review
  kirby_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << kirby_review
  kirby.reviews << kirby_review
end

cartoon_videos.each do |video|
  daffy_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << daffy_review
  daffy.reviews << daffy_review
  kirby_review = Review.create(rating: review_rating, body: review_body)
  video.reviews << kirby_review
  kirby.reviews << kirby_review
end


