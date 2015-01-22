require('rspec')
require('expense')
require('pg')

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
  end
end

describe(Expense) do
  describe('#save') do
    it ("allows you to add and track an expense") do
      expense1 = Expense.new({:description => "coffee", :amount => 3, :date => "2015-01-22"})
      expense1.save()
      expect(Expense.all()).to(eq([expense1]))
    end
  end

  describe('.all') do
    it "lists all expenses" do
      expense1 = Expense.new(:description => "coffee", :amount => 3, :date => "2015-01-22")
      expense1.save()
      expense2 = Expense.new(:description => "coffee", :amount => 3, :date => "2015-01-22")
      expense2.save()
      expect(Expense.all()).to(eq([expense1, expense2]))
    end
  end
end










# Create an app for organizing your expenses. Here are some user stories for you - build one at a time before moving to the next one:
#
# As a user, I want to enter an expense, so I can keep track of where I'm spending my money. I should be able to provide a description
# (for example, "Burgers"), an amount ($7.56), and the date I made the purchase.
