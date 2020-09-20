class DevotionEntriesController < ApplicationController

    get '/devotion_entries' do
        @devotion_entries = DevotionEntry.all
        erb :'devotion_entries/index'
      end


    get '/devotion_entries/new' do
        erb :'/devotion_entries/new'
    end

    post '/devotion_entries' do
        redirect_if_not_logged_in
        if params[:content] != ""
            flash[:message] = "Devotion entry created!"
            @devotion_entry = DevotionEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/devotion_entries/#{@devotion_entry.id}"
        else
            flash[:errors] = "Uh-oh, something went wrong. Can't have an empty devotion."
            redirect '/devotion_entries/new'
        end
    end

    get '/devotion_entries/:id' do
        set_devotion_entry
        erb :'/devotion_entries/show'
    end

    #to edit devotion entries
    get '/devotion_entries/:id/edit' do
        set_devotion_entry
        redirect_if_not_logged_in
        if authorized_to_edit?(@devotion_entry)
            erb :'/devotion_entries/edit'
        else
            redirect "user/#{current_user.id}"
        end
    end

    #patch
    patch '/devotion_entries/:id' do
        set_devotion_entry
        redirect_if_not_logged_in
        if @devotion_entry.user == current_user && params[:content] != ""
            @devotion_entry.update(content: params[:content])
            redirect "/devotion_entries/#{@devotion_entry.id}"
        else
            redirect "users/#{current_user.id}"
        end
    end

    delete '/devotion_entries/:id' do
        set_devotion_entry 
        if authorized_to_edit?(@devotion_entry)
            @devotion_entry.destroy
            flash[:message] = "That Devotion has been deleted"
            redirect '/devotion_entries'
        else
            redirect '/devotion_entries'
        end
    end
    
    private

    def set_devotion_entry
        @devotion_entry = DevotionEntry.find(params[:id])
    end
    
end