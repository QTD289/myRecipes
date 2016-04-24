require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a"*41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "email should be within bounds" do
    @chef.email = "a"*101
    assert_not @chef.valid?
  end
  
  test "email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email should be valid" do
    valid_addresses = %w[user@eee.com R_TDD-D5@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.com]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "invalid email should be rejected" do
    invalid_addresses = %w[user@eee,com R_TDD-D5_at_eee.hello.org user@example. com first.last@e_em.au joe@mo+nk.com]
    invalid_addresses.each do |inva|
      @chef.email = inva
      assert_not @chef.valid?, '#{inva.inspect} should be invalid'
    end
  end
end