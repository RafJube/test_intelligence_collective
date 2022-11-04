module  Admin
  class PagesController < AppAdminController

    def dashboard
      @categories = Category.all
    end

  end
end
