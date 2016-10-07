class SessionsController < ApplicationController
  def new
  end

  def create
    # Look for a user with the given email address and
    # store either that user (if a user was found) or
    # `nil` (if no user was found) in the `user` variable
    user = User.find_by(email: params[:email])

    # If we found a user with that email address AND the
    # given password works with our password digest
    if user && user.authenticate(params[:password])

      # Store the user's id in the session, to keep track
      # of who's signed in (to learn more about this
      # seemingly magical `session` variable Rails provides,
      # [check out these docs](http://guides.rubyonrails.org/security.html#sessions))
      session[:user_id] = user.id

      # Redirect to the `root_url` and display a notice that
      # the user has successfully signed in
      redirect_to root_url, notice: 'Successfully signed in!'

    # If the email or password were wrong
    else

    # Alert the user that their credentials are bad
    flash.alert = 'Invalid email/password combination. Please try again.'

    # Render `new.html.erb` in `app/views/sessions/`
    render :new
  end
  end

  def destroy
    # Set the `:user_id` stored in the `session` back to
    # `nil`, essentially forgetting about the user that
    # was signed in
    session[:user_id] = nil

    # Redirect to the `root_url` and display a notice that
    # the user has successfully signed out
    redirect_to root_url, notice: 'Successfully signed out!'
  end
end
