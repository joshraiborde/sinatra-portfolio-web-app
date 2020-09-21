require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "garden_of_eden"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
    erb :welcome
    end
  end

  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_to_edit?(devotion_entry)
      devotion_entry.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "Sorry, you need to signup or login to be able to view that page."
        redirect '/'
      end
    end


  end

end
