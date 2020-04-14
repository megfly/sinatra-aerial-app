require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "aerial_moves_app"
    register Sinatra::Flash 
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end 
  end

  get '/login' do 
    erb :login
  end 

  post '/login' do #receive the login form, find the user, log the user in
    @user = User.find_by(username: params[:username]) #find user by unique username redirect to users landing page
      if params[:username] !="" && params[:password] != ""
        @user.authenticate(params[:password]) #authenticate user with correct pw
        session[:user_id] = @user.id #log in user to their session
        #puts session #updates action
        redirect "users/#{@user.id}"
      else 
        flash[:error] = "Invalid username or password. Please sign up or try again."
        redirect '/login'
      end
    end 

  get '/logout' do 
    session.clear
    redirect '/'
  end 

  helpers do 

    def logged_in? 
      !!current_user 
      #double bang takes value and turns it into boolean, true if user logged in, otherwise false (context: true, and then negated(false) and then negated again (true))
    end 

    def current_user 
      @current_user ||= User.find_by(id: session[:user_id])
      #This Operator only sets the variable if the variable is false or Nil. so x ||= y this means x || x = y so if x is nil or false set x to be the value of y.
    end 

  end 

end
