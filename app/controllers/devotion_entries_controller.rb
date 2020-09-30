class DevotionEntriesController < ApplicationController

    get '/devotion_entries' do
        @devotion_entries = DevotionEntry.all
        erb :'devotion_entries/index'
      end

    # to render a form to create new entry
    get '/devotion_entries/new' do
        erb :'/devotion_entries/new'
    end
    
    get '/devotion_entries/today' do
        @devotion_entries = DevotionEntry.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
        erb :'/devotion_entries/index'
    end

    get '/devotion_entries/sorted' do
        @devotion_entries = DevotionEntry.all.order(:created_at)
        erb :'/devotion_entries/index'
    end
    

    # to create a new  entry
    post '/devotion_entries' do
        redirect_if_not_logged_in
    # to create a new entry and save it to the db
    # to create a entry only if a user is logged in
    # to save the entry only if it has some content
        if params[:content] != ""
            flash[:message] = "Devotion entry created!"
            @devotion_entry = DevotionEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/devotion_entries/#{@devotion_entry.id}"
        else
            flash[:errors] = "Uh-oh, something went wrong. Can't have an empty devotion."
            redirect '/devotion_entries/new'
        end
    end
    
    # show route for an entry 
    get '/devotion_entries/:id' do
        set_devotion_entry
        erb :'/devotion_entries/show'
    end

    # taken to a show from to edit devotion entries
    get '/devotion_entries/:id/edit' do
        set_devotion_entry
        redirect_if_not_logged_in
        if authorized_to_edit?(@devotion_entry)
            erb :'/devotion_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end
    end

    #patch find entry, update and redirect to show page
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

    # to delete authorized user entries
    delete '/devotion_entries/:id' do
        set_devotion_entry 
        if authorized_to_edit?(@devotion_entry)
            @devotion_entry.destroy
            flash[:errors] = "That Devotion has been deleted"
            redirect '/devotion_entries'
        else
            redirect '/devotion_entries'
        end
    end
    
    # index route for all entries
    private

    def set_devotion_entry
        @devotion_entry = DevotionEntry.find(params[:id])
    end
    
end