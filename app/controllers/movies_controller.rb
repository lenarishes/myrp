class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
     @all_ratings = Movie.ratings   
     if params[:ratings] != nil
      checked_ratings  = params[:ratings].keys
     else
      checked_ratings = @all_ratings
     end
     if params[:order] != nil
     @movies  = Movie.find_all_by_rating(checked_ratings, :order => params[:order])    
     # order_attrib = params[:order]
     #@movies = Movie.order(order_attrib)
      @class_title = params[:title]
      @class_release = params[:release]
      logger.debug("value of @class_title is #{@class_title} and of @class_release is #{@class_release}")
     else 
   # @movies = Movie.all
      @movies  = Movie.find_all_by_rating(checked_ratings)     
      @class_title = false
      @class_release = false
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
