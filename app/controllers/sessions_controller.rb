# This controller handles the login/logout function of the site.
class SessionsController < Devise::SessionsController

  def after_sign_in_path_for user
    if user.admin?
      '/admin'
    else
      cart_path
    end
  end
end
