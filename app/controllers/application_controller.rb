class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper  #http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec-remember_me
end
