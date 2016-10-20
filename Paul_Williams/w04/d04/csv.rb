require 'sinatra'
require 'sinatra/reloader'
require 'csv'

get '/' do
  leads = CSV.read('leads.csv')
  @content = ""
  leads.each do |x|
    @content += "<tr><td>#{x[0]}</td><td>#{x[2]}</td></tr>"
  end
  erb :index
end

=begin
# CSV App

build a sinatra web app with a single route

```
get '/'
```

when a user visit your app at '/' it should display the lead name and phone number in a table

lead|phone number
-----|--------------
Jim Grayson | (555)761-2385
=end
