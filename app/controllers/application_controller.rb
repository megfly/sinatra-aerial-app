require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "aerial_moves_app"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end 
  end

  helpers do 

    def logged_in? 
      !!current_user #double bang takes value and turns it into boolean, true if user logged in, otherwise false
    end 

    def current_user 
      @current_user ||= User.find_by(id: session[:user_id])
    end 

    def current_user_owns_entry?(aerial_entry)
      aerial_entry.user == current_user
    end 

  end 

end
