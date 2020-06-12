require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create(chefname: "zain", email: "zaink@gmail.com")
    @recipe = Recipe.create(name: "vegetables market", description: "great vegetables market with good quality", chef:  @chef)
    @recipe2 = Recipe.create(name: "chicken chilly", description: "great chicken taste", chef: @chef)
  end


 test "should get recipes index" do
   get recipes_path
   assert_response  :success
 end	
 
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_select  "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_match @recipe2.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name

  end



  test "should get recipe show" do 
    get  recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit this Recipe"
    assert_select "a[href=?]". recipe_path(@recipe), text: "Delete this Recipe"
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_templates 'recipes/new'
    name_of_recipe = "TEst"
    description_of_recipe = "TESTTSTSTS"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

   test "reject invalid recipe submissions" do
      get new_recipe_path
      assert_templates 'recipes/new'
      assert_no_difference 'Recipe.count' do
        post recipes_path, params: {recipe: {name: "", description: ""}}
       end
       assert_templates 'recipes/new'
       assert_select 'h2.panel-title'
       assert_select 'div.panel-body'
   end

   test "edit recipes " do

   end

 end