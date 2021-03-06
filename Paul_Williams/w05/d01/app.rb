require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'pry'

get '/' do
  erb :index
end

post '/result' do
  File.open("search_history.txt", 'a') { |f| f << "#{params[:title]}," }
  @search = HTTParty.get "http://omdbapi.com/?s=#{params[:title]}"
  if @search["Error"]
    erb :not_found
  elsif @search["Search"].length == 1
    @info = HTTParty.get "http://omdbapi.com/?i=#{@search["Search"][0]["imdbID"]}"
    erb :movie_info
  else
    @results = @search["Search"].delete_if { |x| x["Poster"] == "N/A" }
    erb :search_result
  end
end

get '/movie_info' do
  @info = HTTParty.get "http://omdbapi.com/?i=#{params[:id]}"
  erb :movie_info
end

get '/about' do
  erb :about
end

get '/history' do
  @history = File.read("search_history.txt").split ","
  erb :history
end

get '/clear' do
  File.open("search_history.txt", 'w') { |f| f << "" }
  redirect "/history"
end

=begin
### Movies_2
* A more advanced version of the Movies Sinatra App

## Summary

The students will update their movies app to allow users to search the database of movies.


## Specification
Instead of returning a single title, the OMDb API allows you t do a search which will return multiple titles.

For example if you search on Jaws, you will get a list like the following:

* Jaws
* Jaws 2
* Jaws 3-D
* Jaws Special
* Jaws Wired Shut

Update your app to allow users to enter a search for movies, and to show the list as a set of links.
Users should then be able to click on the link and go to the movie-etails page (like in your existing app).


### Extra credit:

Consider updating the search functionality so that if you just get one movie back - you don't show the list but take the user straight to the page that shows the information (fewer clicks makes for better user experience).

### Extra extra credit: 

Everytime a user does a search save the movie searched into a file called search_history.txt

add an extra path '/history' that list out all search history
=end
