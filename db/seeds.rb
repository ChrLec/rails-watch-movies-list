# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Cleaning database..."
Movie.destroy_all

puts "Creating movies ..."
for i in 1..8
  api_url = "http://tmdb.lewagon.com/movie/popular?&page=#{i}"
  URI.open(api_url) do |stream|
    films = JSON.parse(stream.read)["results"]
    films.each do |hash|
      movie = Movie.create!(title: hash["original_title"], overview: hash["overview"], poster_url: "https://image.tmdb.org/t/p/original#{hash["poster_path"]}", rating: hash["vote_average"])
      puts "Created #{movie.title}"
    end
  end
end
puts "Finished!"
