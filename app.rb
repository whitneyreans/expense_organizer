require('sinatra')
require('sinatra-contrib')
require('pg')
require('expense')
require('category')

get('/') do
erb(:index)
end

get('/category') do
  erb(:category)
end

get('/expense') do
  erb(:expense)
end
