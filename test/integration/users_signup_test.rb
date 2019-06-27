require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", email: "invalid.com", password: "foo", password_confirmation: "bar" } }
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_error"
  end

  test "valid signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "tester", email: "tester@tester.com", password: "tester", password_confirmation: "tester" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
  end
end
