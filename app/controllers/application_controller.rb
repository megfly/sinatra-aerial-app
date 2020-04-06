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

#signup - render the signup form
  get '/signup' do 
    erb :signup
  end 

    post '/users' do #create new user and persist new user to the database
        #{"name"=>"Name", etc}
      if params[:name] != "" && [:username] !="" && params[:password] != "" #not equal to  empty string
            @user = User.new(name: params["name"], username: params["username"], password: params["password"])
            @user.save

            session[:user_id] = @user.id #logging user in 
            flash[:message] = "Your account has been created, #{@user.name}!"
            # THIS ISNT WORKING
            redirect "users/#{@user.id}"  #{@user.id}" #url
        else 
            #not valid
            flash[:error] = "Account creation failed. Please enter a name, username and password."
            redirect '/signup'
        end 
    end 


  #login - render the login form
  get '/login' do 
    erb :login
  end 

  #receive the login form, find the user, log the user in
  post '/login' do 
    #find user, authenticate user, log in user, redirect to users landing page
    @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password]) #if user returns nil (falsey) it would go to else .....#if @user.save && authenticate??
        session[:user_id] = @user.id
        puts session 
        redirect "users/#{@user.id}"
      else 
        flash[:error] = "Invalid username or password. Please sign up or try again."
        redirect '/login'
      end
    end 

    
    #get '/users/show' do 
        #@user = User.find(session[:user_id])
        #erb :'/users/show'
    #end 



        #user show route- dynamic
        get '/users/:id' do 
          if !logged_in? #if not logged in
              flash[:error] = "Must be logged in to view this page"
              redirect '/users/login'
          else
              @user = User.find_by(id: params[:id])
      #THE BELOW ERB ISNT WORKING
              erb :'/users/show'
          end 
      end 

  get '/logout' do 
    session.clear
    redirect '/'
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

    def redirect_if_not_logged_in 
      if !logged_in? #if not logged in
        flash[:error] = "Must be logged in to view this page"
      else
        redirect '/'
      end 
    end 

  end 

end
