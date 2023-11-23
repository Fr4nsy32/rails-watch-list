# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'rest-client'
require 'json'
require 'faker'
puts 'Cleaning database..'
List.destroy_all
Movie.destroy_all
Bookmark.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated'
response = RestClient.get(url)
puts "Creating movies.."
parse = JSON.parse(response)
parse['results'].each do |result|
  Movie.create!(title: result['title'], overview: result['overview'], poster_url: "https://image.tmdb.org/t/p/w500/#{result['poster_path']}", rating: result['vote_average']  )
  puts "Created #{result['title']}"
end

puts "Creating list.."

List.create!(name: "classic")
List.create!(name: "drama")

List.all.each do |list|
  3.times do
    puts "Creating bookmarks.."
    Bookmark.create!(comment: "This movie was added to a list", movie_id: Movie.all.ids.sample, list_id: list.id )
    puts "Bookmarks created!"
  end
end
