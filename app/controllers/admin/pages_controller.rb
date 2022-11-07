module  Admin
  class PagesController < AppAdminController

    def dashboard
      @categories = Category.all
      @users = User.all
      @tests = Test.all
      @user_tests = UserTest.all
    end

  end
end
