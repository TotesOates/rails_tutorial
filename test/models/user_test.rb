require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new({ name: "joe", email: "joe@joe.com" })
  end

  test "is user valid?" do
    assert @user.valid?
  end

  test "name not present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "user name <= 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user email <= 250 character" do
    @user.email = "a" * 250 + "@email.com"
    assert_not @user.valid?
  end

  test "email is not entered" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "valid email submissions are accepted" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email} is valid"
    end
  end

  test "invalid email are denied" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} is not valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
