require 'rest-client'

puts "Cleaning database..."

User.destroy_all
Astro.destroy_all
Booking.destroy_all

puts "Creating astros..."

def astro_dataset
  # accessing the api and iterating to create astros ...
    astros = RestClient.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_data[:key]}&language=en-US&page=#{page}")
    astros_array = JSON.parse(astros)["results"]
    astros_array.each do |astro|
      Astro.create(
        title: movie["title"],
        overview: movie["overview"],
        year: movie["release_date"][0, 4].to_i,
        poster_url: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/#{movie["poster_path"]}",
        rating: movie["vote_average"]
      )
  end
end

movies_dataset()

puts "Finished seeding the app!"
