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
end
