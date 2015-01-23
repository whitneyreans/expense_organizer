class Category
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end



  define_method(:save) do
    results = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_categories = DB.exec("SELECT * FROM categories;")
    categories = []
    returned_categories.each() do |category|
      name = category.fetch("name")
      id = category.fetch("id").to_i
      categories.push(Category.new({:id => id, :name => name}))
    end
    categories
  end

  define_singleton_method(:find) do |id|
    found_category = []
    Category.all().each() do |category|
      if category.id() == id
        found_category.push(category)
      end
    end
    found_category
  end

  define_method(:==) do |other_category|
    name.==(other_category.name())
  end

  define_method(:add_expense) do |expense|
    expense_id = expense.id().to_i
    self_id = self.id().to_i
    DB.exec("INSERT INTO expenses_categories (expense_id, category_id) VALUES (#{expense_id}, #{self.id()});")
  end

  define_method(:expenses) do
    self_id = self.id()
    expense_array = []
    expenses = DB.exec("SELECT expenses.* FROM
    categories JOIN expenses_categories ON
    (categories.id = expenses_categories.expense_id)
    JOIN expenses ON (expenses_categories.category_id = categories.id)
    WHERE categories.id = #{self.id()};")
    expenses.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount")
      date = expense.fetch("date")
      expense_array.push(Expense.new({:description => description, :amount => amount, :date => date}))
    end
    expense_array
  end
end
