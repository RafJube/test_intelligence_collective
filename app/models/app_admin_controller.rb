class AppAdminController < ApplicationController
  before_action :admin?
  # This controller is for admins of the app
end
