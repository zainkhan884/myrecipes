require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  def setup
    @chef = Chef.create(chefname: "zain", email: "zaink@gmail.com")
    @recipe = Recipe.create(name: "vegetables market", description: "great vegetables market with good quality", chef:  @chef)
  end

  
  test "successfully delete the recipe" do
    get recipe_path(@recipe)
    assert_template 'recipe/show'
    assert_select "[href=?]", recipe_path(@recipe), text: "Delete This Recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipe_path
    assert_not empty?
  end

end
