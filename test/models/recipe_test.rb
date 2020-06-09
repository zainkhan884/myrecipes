require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
 
  def setup
    @recipe = Recipe.new(name: "vegetables", description: "All are greeny vegetables")
  end


 test "recipe should be valid" do 
 	assert @recipe.valid?
 end

 test "name should be present" do
   @recipe.name = ""
   assert_not @recipe.valid?
 end

 test "description should be present" do
   @recipe.description = ""
   assert_not @recipe.valid?
 end

 test "description shouldn't be less than 5 characters" do
   @recipe.description = "a" * 3
   assert_not @recipe.valid?
 end

 test "description shouldn't be more than 300 characters" do
    @recipe.description = "a" * 301
    assert_not @recipe.valid?
  end
end
