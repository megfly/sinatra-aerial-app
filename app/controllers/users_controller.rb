class UsersController < ApplicationController

    #login - render the login form
    get '/login' do 
        erb :login
    end 
    #receive the login form, find the user, log the user in
    post '/login' do 
    end 

    #signup
    get '/signup' do 
    end 

end 