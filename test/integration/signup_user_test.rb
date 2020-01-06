require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest

  test "signup new user to blog" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "john", email: "john@exapmle.com", password: "password"}}
      follow_redirect!
    end
    assert_template 'users/show'
    assert_select 'a', "Log out"
  end

end
