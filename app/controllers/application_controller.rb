require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "aerial_moves_app"
  end

  get "/" do
    erb :welcome
  end

  helpers do 

    def logged_in? 
      !!current_user #double bang takes value and turns it into boolean
    end 

    def current_user 
      @current_user ||= User.find_by(id: session[:user_id])
    end 

  end 

end
