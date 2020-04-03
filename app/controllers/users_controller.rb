class UsersController < ApplicationController

    #login - render the login form
    get '/login' do 
        erb :login
    end 

    #receive the login form, find the user, log the user in
    post '/login' do 
        #find user, authenticate user, log in user, redirect to users landing page
        @user = User.find_by(username: params[:username])
            if @user && @user.authenticate(params[:password]) #if user returns nil (falsey) it would go to else
                session[:user_id] = @user.id
                #puts session 
                redirect "users/#{@user.id}"
            else 
                flash[:error] = "Invalid username or password. Please sign up or try again."
                redirect '/login'
        end
    end 

    #signup - render the signup form
    get '/signup' do 
        erb :signup
    end 

    post '/users' do #create new user and persist new user to the database
        #{"name"=>"Name", etc}
        if params[:name] != "" &&[:email] !="" && params[:password] != "" #not equal to string
            @user = User.create(params)
            session[:user_id] = @user.id #logging user in 
            flash[:message] = "Your account has been created, #{@user.name}!"
            redirect "/users/#{@user.id}" #url
        else 
            #not valid input
            #maybe we should include a message to the user telling them what is wrong
            flash[:error] = "Account creation failed. Please enter a username and password."
            redirect '/signup'
        end 
    end 

    #user show route 
    get '/users/:id' do 
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in 

        erb :'/users/show'
    end 

    get '/logout' do 
        session.clear
        redirect '/'
    end 

end 