class AerialEntriesController < ApplicationController

    get '/aerial_entries' do 
        @aerial_entries = AerialEntry.all
        erb :'/aerial_entries/index' #file reference
    end 

    get '/aerial_entries/new' do 
    #get to render new aerial entry form
        erb :'/aerial_entries/new'
    end 

    post '/aerial_entries' do 
    #create new entry and save to db. Only want to save entry if it has content. Only create if user is logged in.
        if logged_in?
            if params[:move_name] !="" && [:apparatus] !="" && [:difficulty] !="" && [:description] !="" && [:image] !="" #is not an empty string
                flash[:message] = "Entry created!"
                @aerial_entry = AerialEntry.create(move_name: params[:move_name], apparatus: params[:apparatus], difficulty: params[:difficulty], 
                    description: params[:description], image: params[:image], user_id: current_user.id)
                redirect "/aerial_entries/#{@aerial_entry.id}"
            else 
                flash[:error] = "No content"
                #flash messages dont work with erb
                redirect '/aerial_entries/new'
            end 
        else 
            redirect '/'
        end 
    end 

    get '/aerial_entries/:id' do 
    #show route for an aerial entry
        set_aerial_entry
        erb :'/aerial_entries/show'
    end 

    get '/aerial_entries/:id/edit' do 
    #This route should send us to aerial_entries/edit.erb and it will render an edit form
        set_aerial_entry
        if logged_in?
            if current_user_owns_entry?(@aerial_entry)
                erb :'/aerial_entries/edit'
            else 
                redirect "users/#{current_user.id}"
            end 
        else 
            redirect '/'
        end 
    end 

    patch '/aerial_entries/:id' do 
    #This actions job is to find the entry, edit the entry, redirect to show page
        set_aerial_entry
        if logged_in?
            if @aerial_entry.user == current_user && params[:move_name] !="" && [:apparatus] !="" && [:difficulty] !="" && [:description] !="" && [:image] !=""
                @aerial_entry.update(move_name: params[:move_name], apparatus: params[:apparatus], difficulty: params[:difficulty], description: params[:description], 
                image: params[:image])
                @aerial_entry.save
                redirect "/aerial_entries/#{@aerial_entry.id}"
            else 
                redirect "users/#{current_user.id}"
            end 
        else 
            redirect '/'
        end 
    end 

    delete '/aerial_entries/:id' do 
        set_aerial_entry 
        if current_user_owns_entry?(@aerial_entry)
            @aerial_entry.destroy
            redirect '/aerial_entries'
        else 
            redirect '/aerial_entries'
        end 
    end 

    private 

    def set_aerial_entry #find users particular journal entry
        @aerial_entry = AerialEntry.find(params[:id])
    end 

    def current_user_owns_entry?(aerial_entry)
        aerial_entry.user == current_user
    end 

end 