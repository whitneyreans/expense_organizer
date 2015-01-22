class Expense
  attr_reader(:description, :amount, :date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)

  end

  define_method(:save) do
    DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}');")
  end

  define_singleton_method(:all) do
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    expenses = []
    returned_expenses.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_i
      date = expense.fetch("date")
      expenses.push(Expense.new({:description => description, :amount => amount, :date => date}))
    end
    expenses
  end

  define_method(:==) do |other_expense|
    description.==(other_expense.description())
    .&(amount.==(other_expense.amount()))
    .&(date.==(other_expense.date()))
  end
end
