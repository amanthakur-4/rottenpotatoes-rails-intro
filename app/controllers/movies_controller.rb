class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID fro m URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @title_header = ""
    @date_header = ""
    @all_ratings = Movie.get_all_ratings()
    sort_by = params[:sort] || session[:sort]
    ratings_list = params[:ratings]&.keys || session[:ratings] || @all_ratings
    
    @movies = Movie.with_ratings(ratings_list, sort_by)
    
    if sort_by == "title"
      @title_header = "hilite bg-warning"
    elsif sort_by == "date"
      @date_header = "hilite bg-warning"
    end
    
    session[:ratings] = ratings_list
    session[:sort] = sort_by
    
    @ratings_to_show = ratings_list
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
