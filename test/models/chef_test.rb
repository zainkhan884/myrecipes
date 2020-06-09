# require 'test_helper'

# class ChefTest < ActiveSupport::TestCase
 
#   def setup
#     @chef = Chef.new(chefname: "zain", email: "zain@gmail.com")
#   end

#  test "should be valid" do 	
#  	assert @chef.valid?
#  end

#  test "name should be present" do
#    @chef.chefname = ""
#    assert_not @chef.valid?
#  end

#  test " name should be less than 30 characters" do
#    @chef.chefname = "a" * 31
#    assert_not @chef.valid?
#  end

#  test "email should be present" do
#   @chef.email = ""
#   assert_not @chef.valid?
#  end

#  test " email should not be too long" do
#  	@chef.email = "a" * 245 + "@example.com"
#  	assert_not @chef.valid?
#  end

#  test "email should accept correct format" do
#    valid_emails = %w[zain@example.com user@gmail.com abc@yahoo.com john+snith@co.uk.org]
#    valid_emails.each do |valid|
#    @chef.email = valid
#    assert @chef.valid?, "#{valid.inspect} should be valid"
#    end
#  end

#   test "email should be invalid " do
#   	invalid_emails = %w[user@gmail abc@ jo*12334.com]
#   	invalid_emails.each do |invalids|
#   		@chef.email = invalids
#   		assert_not @chef.valid?, "#{invalids.inspect} should be invalids"
#      end
#    end

#   test "email should be unique and case insensitive" do
#     duplicate_chef = @chef.dup
#     duplicate_chef.email = @chef.email.upcase
#     @chef.save
#     assert_not duplicate_chef.valid?
#   end

#   test "email should be lower case before hitting db" do
#   	mixed_email = "Test@gmail.com"
#   	@chef.email = mixed_email
#   	@chef.save
#   	assert_equal mixed_email.downcase, @chef.reload.email
#   end
  
# end
