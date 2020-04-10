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

  get '/signup' do 
    #renders the signup form
    erb :signup
  end 

  post '/users' do #create new user and persist new user to the database
    if params[:name] != "" && [:username] !="" && params[:password] != "" #not equal to  empty string
      @user = User.new(name: params["name"], username: params["username"], password: params["password"])
      @user.save

      session[:user_id] = @user.id #logging user in 
      flash[:message] = "Your account has been created, #{@user.name}!"
      redirect "users/#{@user.id}"  #{@user.id}" #url
    else 
      flash[:error] = "Account creation failed. Please enter a name, username and password."
      redirect '/signup'
    end 
  end 

  get '/login' do 
    erb :login
  end 

  post '/login' do #receive the login form, find the user, log the user in
    @user = User.find_by(username: params[:username]) #find user, authenticate user, log in user, redirect to users landing page
      if @user.authenticate(params[:password]) #if user returns nil (falsey) it would go to else .....#if @user.save && authenticate??
        session[:user_id] = @user.id
        puts session #updates action
        redirect "users/#{@user.id}"
      else 
        flash[:error] = "Invalid username or password. Please sign up or try again."
        redirect '/login'
      end
    end 


        
    get '/users/:id' do #user show route- dynamic
      if !logged_in? #if not logged in
        flash[:error] = "Must be logged in to view this page"
        redirect '/users/login'
      else
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
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

    def current_user_owns_entry?(aerial_entry)
      aerial_entry.user == current_user
    end 

    def redirect_if_not_logged_in 
      if !logged_in? #if not logged in
        flash[:error] = "Must be logged in to view this page"
      else
        redirect '/'
      end 
    end 

  end 

end
