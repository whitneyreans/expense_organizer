require("spec_helper")

describe(Expense) do
  describe('#save') do
    it ("allows you to add and track an expense") do
      expense1 = Expense.new({:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22"})
      expense1.save()
      expect(Expense.all()).to(eq([expense1]))
    end
  end

  describe('.all') do
    it "lists all expenses" do
      expense1 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense1.save()
      expense2 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense2.save()
      expect(Expense.all()).to(eq([expense1, expense2]))
    end
  end

  describe('#id') do
    it "sets the id of the expense" do
      expense1 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense1.save()
      expect(expense1.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#==') do
    it("sets equal expenses with the same amount, description, and date") do
      expense1 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense1.save()
      expense2 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense2.save()
      expect(expense1.==(expense2)).to(eq(true))
    end
  end

  describe('.find') do
    it "finds the expense by its id" do
      expense1 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense1.save()
      expense2 = Expense.new(:id => nil, :description => "coffee", :amount => 3, :date => "2015-01-22")
      expense2.save()
      expect(Expense.find(expense1.id)).to eq([expense1])
    end
  end


end
