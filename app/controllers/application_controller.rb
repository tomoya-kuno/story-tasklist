class ApplicationController < ActionController::Base
  
  include SessionsHelper
  # 下記のlogged_in?を使用するために
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
