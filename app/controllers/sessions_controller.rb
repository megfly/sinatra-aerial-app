class SessionsController < ApplicationController 
    
    #login - render the login form
    get '/login' do 
        erb :login
    end 

    #receive the login form, find the user, log the user in
    post '/login' do 
        #find user, authenticate user, log in user, redirect to users landing page
        @user = User.find_by(username: params[:username])
            if @user.save #&& @user.authenticate(params[:password]) #if user returns nil (falsey) it would go to else
                session[:user_id] = @user.id
                redirect "users/#{@user.id}"
            else 
                flash[:error] = "Invalid username or password. Please sign up or try again."
                erb :'/users/login'
        end
    end 

    get '/logout' do 
        session.clear
        redirect '/'
    end 
end 