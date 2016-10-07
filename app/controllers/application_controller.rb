class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Anything that ISN'T an action attached to a route should be
  # in a `private` section of a controller.
  private

  def current_user
    # Looks for a user with the id stored in the session, if there
    # is one. If `session[:user_id]` is `nil`, then the `find_by`
    # will also return `nil`.
    User.find_by(id: session[:user_id])
  end
  # Turns this private method into a helper method that can be
  # used not only in our controllers, but also in our views.
  helper_method :current_user

  def user_signed_in?
    # Takes `current_user`, which will either contain a valid user
    # (which would be "truthy") or `nil` (which would be "falsy")
    # and gets a `true` or `false` value from those, respectively.
    !!current_user
  end
  # Turns this private method into a helper method that can be
  # used not only in our controllers, but also in our views.
  helper_method :user_signed_in?

  def only_allow_signed_in_users
    unless user_signed_in?
      redirect_to sign_in_url, notice: 'You must sign in to access this part of the app.'
    end
  end
  
end
