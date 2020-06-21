require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "zain", email: "zaink@gmail.com",
                         password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetables market", description: "great vegetables market with good quality", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name: "", description: "test sa0mple" }}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
   end

  test "successfully added recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "update"
    update_description = "description"
    patch recipe_path(@recipe), params: {recipe: {name: updated_name, description: update_description}}
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name , @recipe.name
    assert_match update_description, @recipe.description
    #follow_redirect! 
  end

end
