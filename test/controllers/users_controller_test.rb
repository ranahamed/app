require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

#test el7agat elktbtha fe url 7yro7lha ?
def setup
    @user = users(:michael)
     @other_user = users(:archer)
 end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do #lw ktbtha fe url msh 3ayza aro7lha 3ltol
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
  	 log_in_as(@other_user)
 	patch user_path(@user), params: {user:{name: @user.name,
 											email: @user.email }}
    assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do #want to see users lazm a3ml login
   get users_path
   assert_redirected_to login_url
  end

 test "should redirect destroy when not logged in" do
  assert_no_difference 'User.count' do
    delete user_path(@user)
  end
  assert_redirected_to login_url
 end

 test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
