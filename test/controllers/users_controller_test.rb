require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "get new user page" do
    get new_user_path
    assert_template :new
  end

  test "create user succeeded" do

    post users_path, params: { user: { email: "zen00326598@gmail.com", first_name: "aaassda", last_name: "bbasd", address: "csdac" } }
    # 成功後最後新增的email會與剛剛新增的資料相同
    assert_equal "zen00326598@gmail.com", User.last.email
    # 新增成功所會顯示的提示
    assert_equal "Welcome to fandnext", flash[:success]
    # 導向user index
    get users_path
  end

  test "create user failed" do
    post users_path, params: { user: { email: "aasda@maileven.com", first_name: "aasda", last_name: "bbasd", address: "csdac" } }
    # domain是錯誤的
    assert_equal "Domain invalid", flash.now[:warning]
    # 失敗render new畫面
    assert_template :new
  end
end