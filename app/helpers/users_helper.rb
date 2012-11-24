module UsersHelper
  def form_select_category
    categories_title_and_id = []
    categories = Category.find_all_by_super(1)
    categories.each do |category|
      subcategories = Category.find_all_by_super(category.id)
      subcategories.each do |subcategory|
        categories_title_and_id << [category.title + "_" + subcategory.title, subcategory.id]
      end
    end
    categories_title_and_id
  end

end
