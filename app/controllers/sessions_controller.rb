# This controller handles the login/logout function of the site.
class SessionsController < Devise::SessionsController

  skip_before_filter :admin_status_required, :only => [:destroy, :create]

  def after_sign_in_path_for user
    if user.admin?
      '/admin'
    else
      cart_path
    end
  end

  def after_sign_out_path_for user
    new_user_session_path
  end
end
