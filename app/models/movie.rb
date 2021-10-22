class Movie < ActiveRecord::Base
  
  attr_accessor :all_ratings
  
  @@all_ratings = ['G', 'PG', 'PG-13', 'R'] 
  
  def self.get_all_ratings()
    return @@all_ratings
  end
  
  def self.with_ratings(ratings_list, sort_by)
    if sort_by == nil
      return Movie.where(rating: ratings_list)
    elsif sort_by == "title"
      return Movie.where(rating: ratings_list).order(:title)
    else
      return Movie.where(rating: ratings_list).order(:release_date)
    end
  end
end
