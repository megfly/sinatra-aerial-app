class UsersController < ApplicationController

    #login - render the login form
    get '/login' do 
        erb :login
    end 

    #signup
    get '/signup' do 
    end 

end 