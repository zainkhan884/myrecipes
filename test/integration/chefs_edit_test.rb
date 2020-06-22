require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname: "zain", email: "zaink@gmail.com",
                         password: "password", password_confirmation: "password")
   # @chef2 = Chef.create!(chefname: "zain", email: "zaink@gmail.com",
           #              password: "password", password_confirmation: "password")
    @admin_user= Chef.create!(chefname: "zain3", email: "zain786k@gmail.com",
                         password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: "", email: "zaink@gmail.com" }}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  

  test "accept valid edit " do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: { chefname: "zain1", email: "zain76@gmail.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "zain1", @chef.chefname
    assert_match "zain76@gmail.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: { chefname: "zain3", email: "zain786@gmail.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "zain3", @chef.chefname
    assert_match "zain786@gmail.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user " do
    sign_in_as(@chef, "password")
    updated_name = "jeo"
    updated_email = "jeo@gmail.com"
    patch chef_path, params: {chef: { chefname: updated_name, email: updated_email }}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "zain", @chef.chefname
    assert_match "zaink@gmail.com", @chef.email
  end 
end
