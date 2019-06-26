require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info" do
    get sign_up_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", email: "invalid.com", password: "foo", password_confirmation: "bar" } }
    end
    assert_template "users/new"
    assert_select "div#error_explaination"
    assert_select "div.field_with_error"
  end
end
