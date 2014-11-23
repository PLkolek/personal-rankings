class Admin::DashboardController < Admin::AdminController
  before_action :authenticate_user!
  def index
  end
end
