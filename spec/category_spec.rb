require('rspec')
require('expense')
require('category')
require('pg')

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM categories *;")
  end
end
