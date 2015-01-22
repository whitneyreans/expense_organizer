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

describe(Category) do
  describe('#save') do
    it ("allows you to save a category") do
      category1 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      expect(Category.all()).to(eq([category1]))
    end
  end

  describe('.all') do
    it("lists all categories") do
      category1 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      category2 = Category.new({:name => "Wine", :id => nil})
      category2.save()
      expect(Category.all()).to(eq([category1, category2]))
    end
  end

  describe('#id') do
    it "sets the id of the category" do
      category1 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      expect(category1.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#==') do
    it("sets equal Categories with the same name") do
      category1 = Category.new({:name => "Beer", :id => nil})
      category2 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      category2.save()
      expect(category1.==(category2)).to(eq(true))
    end
  end

  describe('.find') do
    it("finds the expense by its id") do
      category1 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      category2 = Category.new({:name => "Beer", :id => nil})
      category2.save()
      expect(Category.find(category1.id)).to(eq([category1]))
    end
  end

  describe('#expenses') do
    it("lists all of the expenses within that category") do
      category1 = Category.new({:name => "Beer", :id => nil})
      category1.save()
      expense1 = Expense.new({:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22"})
      expense1.save()
      expect(category1.expenses()).to(eq([expense1]))
    end
  end
end
