require "test_helper"

class UserActivationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @non_activated_user = users(:non_activated_user)
  end

  test "index only activated user" do
    log_in_as(@user)
    get users_path
    assert_template "users/index"
    assert_select "a[href=?]",user_path(@user)
    assert_select "a[href=?]",user_path(@non_activated_user),count:0
  end

  test "show only activated user" do
    log_in_as(@user)
    get user_path(@user)
    assert_template "users/show"
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end
end
