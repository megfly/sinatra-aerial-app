class UsersController < ApplicationController

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
  
    # helpers do 

    #     def logged_in? 
    #       !!current_user 
    #       #double bang takes value and turns it into boolean, true if user logged in, otherwise false (context: true, and then negated(false) and then negated again (true))
    #     end 
    
    #     def current_user 
    #       @current_user ||= User.find_by(id: session[:user_id])
    #       #This Operator only sets the variable if the variable is false or Nil. so x ||= y this means x || x = y so if x is nil or false set x to be the value of y.
    #     end 
    
    # end 

end 