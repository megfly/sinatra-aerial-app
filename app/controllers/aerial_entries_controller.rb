class AerialEntriesController < ApplicationController

    get '/aerial_entries' do 
        @aerial_entries = AerialEntry.all
        erb :'/aerial_entries/index' #file reference
    end 

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
        set_aerial_entry
        erb :'/aerial_entries/show'
    end 

    #This route should send us to aerial_entries/edit.erb and it will render an edit form
    get '/aerial_entries/:id/edit' do 
        set_aerial_entry
        only_current_user 
    end 

    #This actions job is to find the entry, edit the entry, redirect to show page
    patch '/aerial_entries/:id' do 
        set_aerial_entry
        only_current_user
        @aerial_entry.update(move_name: params[:move_name], apparatus: params[:apparatus], difficulty:
        params[:difficulty], description: params[:description])
        redirect "/aerial_entries/#{@aerial_entries.id}"
    end 

    #index for all


    private 

    def set_aerial_entry #find users particular journal entry
        @aerial_entry = AerialEntry.find(params[:id])
    end 

    def only_current_user
        if logged_in?
            if @aerial_entry.user == current_user
                erb :'/aerial_entries/edit' #file
            else
                redirect "/users/#{current_user.id}"
            end
        else 
            redirect '/'
        end 
    end 

    #make helper method to ensure users cant modify content created by someone else
    #edit update, helper
end 