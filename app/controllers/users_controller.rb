class UsersController < ApplicationController

    #signup - render the signup form
    get '/signup' do 
        erb :signup
    end 

    post '/users' do #create new user and persist new user to the database
        #{"name"=>"Name", etc}
        if params[:name] != "" &&[:email] !="" && params[:password] != "" #not equal to  empty string
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

end 