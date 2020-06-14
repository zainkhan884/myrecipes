require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "zain", email: "zaink@gmail.com",
                         password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetables market", description: "great vegetables market with good quality", chef: @chef)
    @recipe2 = Recipe.create(name: "chicken chilly", description: "great chicken taste", chef: @chef)
  end
  
  test "should get chefs show " do
  	get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select  "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select  "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
end
