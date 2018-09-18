require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { access: @user.access, age: @user.age, date_of_birth: @user.date_of_birth, email: @user.email, ethnicity: @user.ethnicity, first_name: @user.first_name, last_name: @user.last_name, password: @user.password, salary: @user.salary, social_security_number: @user.social_security_number, years_experience: @user.years_experience } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { access: @user.access, age: @user.age, date_of_birth: @user.date_of_birth, email: @user.email, ethnicity: @user.ethnicity, first_name: @user.first_name, last_name: @user.last_name, password: @user.password, salary: @user.salary, social_security_number: @user.social_security_number, years_experience: @user.years_experience } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
