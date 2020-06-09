require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "zain", email: "zaink@gmail.com")
    @recipe = Recipe.create(name: "vegetables market", description: "great vegetables market with good quality", chef: @chef)
    @recipe2 = Recipe.create(name: "chicken chilly", description: "great chicken taste", chef: @chef)
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  # test "should get recipes listing" do
  #    get recipes_path
  #    assert_template 'recipes/index'
  #    assert_match @recipe.name, response.body
  # #   assert_select  "a[href=?]", recipe_path(@recipe), text: @recipe.name
  #    assert_match @recipe2.name, response.body
  #   # assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  # end

end