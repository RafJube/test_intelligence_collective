class AppAdminController < ApplicationController
  before_action :admin?

  def admin?
    redirect_to root_path unless authenticate_user!.admin
  end
end
