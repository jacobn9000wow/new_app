module SessionsHelper

  def sign_in(user) #http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec-a_working_sign_in_method
    cookies.permanent[:remember_token] = user.remember_token #the cookies utility supplied by Rails. We can use cookies as if it were a hash
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # uses the common but initially obscure ||= (“or equals”) assignment operator (Box 8.2). Its effect is to set the @current_user instance variable to the user corresponding to the remember token, but only if @current_user is undefined. In other words, the construction calls the find_by_remember_token method the first time current_user is called, but on subsequent invocations returns @current_user without hitting the database. This is an example of memoization. This is only useful if current_user is used more than once for a single user request; in any case, find_by_remember_token will be called at least once every time a user visits a page on the site.
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
