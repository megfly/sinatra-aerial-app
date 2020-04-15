class UsersController < ApplicationController

    get '/signup' do 
        #renders the signup form
        erb :signup
    end 
    
    post '/users' do #create new user and persist new user to the database
        if params[:name] != "" && [:username] !="" && params[:password] != "" #not equal to  empty string

          @user = User.create(name: params["name"], username: params["username"], password: params["password"])
          #@user.save
          session[:user_id] = @user.id #logging user in 
          flash[:message] = "Your account has been created, #{@user.name}!"
          redirect "users/#{@user.id}"  #{@user.id}" #url
        else 
          flash[:error] = "All fields required."
          redirect '/signup'
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
  
end 