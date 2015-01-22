class Expense
  attr_reader(:id, :description, :amount, :date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)
    @id = attributes.fetch(:id)
  end

  # define_method(:id) do


  define_method(:save) do
    results = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}') RETURNING id;")
    @id = results.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    expenses = []
    returned_expenses.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_i
      date = expense.fetch("date")
      id = expense.fetch("id").to_i
      expenses.push(Expense.new({:id => id, :description => description, :amount => amount, :date => date}))
    end
    expenses
  end

  define_singleton_method(:find) do |id|
    found_expense = []
    Expense.all().each() do |expense|
      if expense.id() == id
        found_expense.push(expense)
      end
    end
    found_expense
  end


  define_method(:==) do |other_expense|
    description.==(other_expense.description())
    .&(amount.==(other_expense.amount()))
    .&(date.==(other_expense.date()))
  end
end
