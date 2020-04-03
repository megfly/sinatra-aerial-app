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
            flash[:message] = "Entry created!"
            @aerial_entry = AerialEntry.create(move_name: params[:move_name], apparatus: params[:apparatus], difficulty: params[:difficulty], description: params[:description], user_id: current_user.id)
            redirect "/aerial_entries/#{@aerial_entry.id}"
        else 
            flash[:message] = "No content" #maybe do :error and style so its red..
            #flash messages dont work with erb
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
        redirect_if_not_logged_in
        if current_user_owns_entry?(@aerial_entry)
            erb :'/aerial_entries/edit'
        else 
            redirect "users/#{current_user.id}"
        end 
    end 

    #This actions job is to find the entry, edit the entry, redirect to show page
    patch '/aerial_entries/:id' do 
        set_aerial_entry
        redirect_if_not_logged_in
            if @aerial_entry.user == current_user && params[:move_name] !="" && [:apparatus] !="" && [:difficulty] !="" && [:description] !="" && [:image] !=""
            @aerial_entry.update(move_name: params[:move_name], apparatus: params[:apparatus], difficulty: params[:difficulty], description: params[:description], image: params[:image])
        redirect "/aerial_entries/#{@aerial_entries.id}"
            else 
                redirect "users/#{current_user.id}"
            end 
    end 

    delete '/aerial_entries/:id' do 
        set_aerial_entry 
        if current_user_owns_entry?(@aerial_entry)
            @aerial_entry.destroy
            redirect '/aerial_entries' #redirect to take care of an action and send us on our way(change something). get request- erb will 
            #SHOW a form
        else 
            redirect '/aerial_entries'
        end 
    end 


    private 

    def set_aerial_entry #find users particular journal entry
        @aerial_entry = AerialEntry.find(params[:id])
    end 

    #def only_current_user
        #if logged_in?
            #if @aerial_entry.user == current_user
                #erb :'/aerial_entries/edit' #file
            #else
                #redirect "/users/#{current_user.id}"
            #end
        #else 
            #redirect '/'
        #end 
    #end 

end 