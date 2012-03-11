class Movie < ActiveRecord::Base
@@ratings = ['G', 'PG', 'PG-13', 'R']
def Movie.ratings; @@ratings; end
end
