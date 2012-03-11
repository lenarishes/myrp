class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
     @all_ratings = Movie.ratings   
     #flag for changing bg color of sorting index
     @class_hilite = '0'
     #hash to keep checkbox values
     @checked = {}
     @all_ratings.each do |rating|
      @checked[rating] = false
     end
     if params[:ratings] != nil
      params[:ratings].keys.each do |rating|
       @checked[rating] = true
      end
     end
     checked_ratings = @checked.select {|k,v| v == true} #returns a hash
     if checked_ratings.empty?
      #nothing is checked
      checked_ratings = @all_ratings
     else
       checked_ratings = checked_ratings.keys #we need only rating names
     end
     if params[:order] != nil
     @movies  = Movie.find_all_by_rating(checked_ratings, :order => params[:order])    
     @class_hilite = params[:hilite]
      # logger.debug("value of @class_title is #{@class_title} and of @class_release is #{@class_release}")
     else 
   # @movies = Movie.all
      @movies  = Movie.find_all_by_rating(checked_ratings)     
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
