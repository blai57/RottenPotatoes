require 'faraday'
require 'json'

class Movie < ActiveRecord::Base
      
    def self.all_ratings
      ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.with_ratings(ratings, sort_by)
      if ratings.nil?
        all.order sort_by
      else
        where(rating: ratings.map(&:upcase)).order sort_by
      end
    end

    def self.find_in_tmdb(string)
      string_json = Faraday.get('https://api.themoviedb.org/3/search/movie?api_key=YOUR_API_KEY_HERE', string)
      #parse Json
      response = JSON.parse(string_json.body)
      new_array = Array.new
      for i in 0...response["results"].length()
        # Create an Array of new objects
        #Example: User.create([{ :first_name => 'Jamie' }, { :first_name => 'Jeremy' }])
        title = response["results"][i]["original_title"]
        release_date = response["results"][i]["release_date"]
        #assuming there are no release dates, let's parse the ones that have release dates.
        if !release_date.empty?
          release_date = Date.parse(release_date)
        end
        synopsis = response["results"][i]["overview"]
        language = response["results"][i]["original_language"]
        new_array.append({:title => title, :rating => 'R', :description => synopsis, :release_date => release_date})
      end
      new_array
    end
  
end
  