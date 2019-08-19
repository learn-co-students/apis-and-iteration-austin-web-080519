require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  #iterate into the results to find where name is equal to character provided by user 
  character_data = character_hash["results"].find{|data| data["name"] == character}

  # iterate over the response hash to find the collection of `films` for the given 
  # 'character'
  character_films = character_data["films"]
  films = character_films.collect { |film_url| 
    JSON.parse(RestClient.get(film_url))
  }
  films
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  puts "-------------------------running print_movies method ---------------"
  puts films.collect{|film| film["title"]}
end


def show_character_movies(character)
  #puts character
  films = get_character_movies_from_api(character)
  print_movies(films)
  #binding.pry
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
