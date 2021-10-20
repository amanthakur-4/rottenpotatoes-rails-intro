class Movie < ActiveRecord::Base
  
  attr_accessor :all_ratings
  
  @@all_ratings = ['G', 'PG', 'PG-13', 'R'] 
  
  def self.get_all_ratings()
    return @@all_ratings
  end
  
  def self.with_ratings(ratings_list)
    Movie.where(rating: ratings_list)
  end
end
