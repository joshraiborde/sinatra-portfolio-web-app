class DevotionEntriesController < ApplicationController

    get '/devotion_entries' do
        @devotion_entries = DevotionEntry.all
        erb :'devotion_entries/index'
      end


    get '/devotion_entries/new' do
        erb :'/devotion_entries/new'
    end

    post '/devotion_entries' do

        if !logged_in?
            redirect '/'
        end
        if params[:content] != ""
            @devotion_entry = DevotionEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/devotion_entries/#{@devotion_entry.id}"
        else
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
        if logged_in?
            if authorized_to_edit?(@devotion_entry)
                erb :'/devotion_entries/edit'
            else
                redirect "user/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    #patch
    patch '/devotion_entries/:id' do
        set_devotion_entry
        if logged_in?
            if @devotion_entry.user == current_user
                @devotion_entry.update(content: params[:content])
                redirect "/devotion_entries/#{@devotion_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end        
    end
    
    private

    def set_devotion_entry
        @devotion_entry = DevotionEntry.find(params[:id])
    end
    
end