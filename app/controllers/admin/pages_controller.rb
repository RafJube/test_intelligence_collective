module  Admin
  class PagesController < AppAdminController

    def dashboard
      @categories = Category.all
      @users = User.all
      @games = Game.all
      @user_games = UserGame.all
    end

  end
end
