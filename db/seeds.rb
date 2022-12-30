require 'rest-client'

puts "Cleaning database..."

User.destroy_all
Astro.destroy_all
Booking.destroy_all

puts "Creating astros..."

def astros_dataset
  # accessing the api and iterating to create astros ...
  astros = RestClient.get("https://api.le-systeme-solaire.net/rest/bodies/")
  astros_array = JSON.parse(astros)["bodies"]
  astros_array.each do |astro|
    Astro.create(
      name: astro["englishName"],
      body_type: astro["bodyType"],
      average_temperature: astro["avgTemp"],
      density: astro["density"],
      gravity: astro["gravity"],
      mean_radius: astro["meanRadius"],
      discovered_by: astro["discoveredBy"],
      discovered_date: astro["discoveryDate"],
      price: ((astro["meanRadius"].to_i) + 250) * 50,
      image_url: "",
      around_planet: astro["aroundPlanet"] == nil ? "" : astro["aroundPlanet"]["planet"].capitalize,
      mass_value: astro["mass"] == nil ? "Unknown" : "#{astro['mass']['massValue']}x10^#{astro['mass']['massExponent']}",
      volume: astro["vol"] == nil ? "Unknown" : "#{astro['vol']['volValue']}x10^#{astro['vol']['volExponent']}"
    )
  end
end

astros_dataset()

puts "Finished seeding the app!"

# how to get the description
# astro_info = Astronomy::Information.new.search "Uranus"
# astro_info.each { |astro| puts astro["description"] if astro["name"] == "Uranus" }
