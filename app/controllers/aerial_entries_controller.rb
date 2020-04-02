class AerialEntriesController < ApplicationController

    #get to render form
    get '/aerial_entries/new' do 
        erb :'/aerial_entries/new'
    end 

    #post aerial entries to create a new entry
    post '/aerial_entries' do 
        #create new entry and save to db. Only want to save entry if it has content. Only create if user is logged in.
        if !logged_in?
            redirect '/'
        end 
        if params[:move_name] !="" && [:apparatus] !="" && [:difficulty] !="" && [:description] !="" #is not an empty string
            #create new
            @aerial_entry = AerialEntry.create(move_name: params[:move_name], apparatus: params[:apparatus], difficulty:
            params[:difficulty], description: params[:description], user_id: current_user.id)
            redirect "/aerial_entries/#{@aerial_entry.id}"
        else 
            redirect '/aerial_entries/new'
        end 
    end 

    #show route for an aerial entry
    get '/aerial_entries/:id' do 
        @aerial_entry = AerialEntry.find(params[:id])
        erb :'/aerial_entries/show'
    end 

    #This route should send us to aerial_entries/edit.erb and it will render an edit form
    get '/aerial_entries/:id/edit' do 
        erb :'/aerial_entries/edit' #file
    end 

    #index for all
end 