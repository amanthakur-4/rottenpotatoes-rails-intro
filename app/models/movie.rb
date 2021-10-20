class Movie < ActiveRecord::Base
  
  @@all_ratings = ['G', 'PG', 'PG-13', 'R'] 
  @ratings_to_show = []
  
  def self.get_all_ratings()
    return @@all_ratings
  end
  
  def self.with_ratings(ratings_list)
    Movie.where(rating: ratings_list)
  end
end
