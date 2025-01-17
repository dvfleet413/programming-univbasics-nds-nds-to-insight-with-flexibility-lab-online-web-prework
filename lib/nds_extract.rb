# Provided, don't edit
require 'directors_database'
require 'pp'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  #
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method

  result = []
  movie_index = 0
  while movie_index < movies_collection.length do 
    result << movie_with_director_name(name, movies_collection[movie_index])
    movie_index += 1
  end
  result
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  
  totals = {}
  i = 0
  while i < collection.length do
    studio = collection[i][:studio]
    if !totals[studio]
      totals[studio] = collection[i][:worldwide_gross]
    else
      totals[studio] += collection[i][:worldwide_gross]
    end
    i += 1
  end
  totals
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it. --> use movies_with_director_names
  
  # { :name => "A", :movies => [{ :title => "Test" }] }
  #        # becomes... [[{:title => "Test", :director_name => "A"}], ...[], ... []]

  result = []
  director_index = 0
  while director_index < source.length do
    movie_index = 0
    director_array = []
    while movie_index < source[director_index][:movies].length do
      #include :worldwide_gross and :studio in order for studios_totals method to work
      element = {
        :title => source[director_index][:movies][movie_index][:title], 
        :director_name => source[director_index][:name], 
        :worldwide_gross => source[director_index][:movies][movie_index][:worldwide_gross],
        :studio => source[director_index][:movies][movie_index][:studio]
      }
      director_array << element
      movie_index += 1
    end
    result << director_array
    director_index += 1
  end
  result
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
