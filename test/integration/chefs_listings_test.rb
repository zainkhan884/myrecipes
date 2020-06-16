require 'test_helper'

class ChefsListingsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

 def setup
    @chef = Chef.create!(chefname: "zain", email: "zaink@gmail.com",
                         password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "akash", email: "akash@gmail.com",
    	                    password: "password", password_confirmation: "password")
 end

  test "should get chefs index" do
   get chefs_path
   assert_response  :success
 end	

 test "" do
   get chefs_path
   assert_template 'chefs/index'
   assert_select  "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
   assert_select  "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
 end

 test "should delete chef " do
   get chefs_path
   assert_template 'chefs/index'
   assert_difference 'Chef.count', -1 do
     delete chef_path(@chef2)
   end
   assert_redirected_to chefs_path
   assert_not flash.empty?
 end
 
end
