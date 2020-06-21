require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "zain", email: "zainkhan@gmail.com", password: "password")
  end

  test "invalid login to be rejected " do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: "", password: "" }}
    assert_template 'sessions/new'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end


  test " valid login accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: @chef.email, password: @chef.password }}  
    #assert_redirected_to @chef
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", chef_path(@chef)
    assert_select "a[href=?]", edit_chef_path(@chef)
  end
end
