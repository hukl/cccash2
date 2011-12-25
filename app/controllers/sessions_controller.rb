# This controller handles the login/logout function of the site.
class SessionsController < Devise::SessionsController

  skip_before_filter :admin_status_required, :only => [:destroy, :create]

  before_filter :change_workshift_state, :only => [:destroy]

  def after_sign_in_path_for user
    if user.admin?
      '/admin'
    else
      if user.workshift
        user.workshift.login!
      end
      cart_path
    end
  rescue
    flash[:notice] = "Workshift not active"
    sign_out(user)
    new_user_session_path
  end

  def after_sign_out_path_for user
    new_user_session_path
  end

  private

  def change_workshift_state
    current_user.workshift.logout!
  rescue
    true
  end
end
