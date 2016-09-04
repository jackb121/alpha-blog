require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  
  test "Ensure user is properly signed up" do
    post users_path, user: {username: "john", email: "john@example.com", password: "password"}
    assert user.valid?
  end
end