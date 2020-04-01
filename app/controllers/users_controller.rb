class UsersController < ApplicationController

    #login - render the login form
    get '/login' do 
        erb :login
    end 

    #receive the login form, find the user, log the user in
    post '/login' do 
        #find user, authenticate user, log in user, redirect to users landing page
        @user = User.find_by(username: params[:username])
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect "users/#{@user.id}"
            else 
        end
    end 

    #signup
    get '/signup' do 

    end 

    #user show route 
    get '/users/:id' do 
        "this will be the user show route"
    end 

end 