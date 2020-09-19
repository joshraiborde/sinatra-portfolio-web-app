class UsersController < ApplicationController

    #login page
    get '/login' do
        erb :login
    end

    #login form
    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts session
            redirect "users/#{@user.id}"

        else

        end
        
    end

    get 'signup' do
        
    end

    #show route
    get '/users/:id' do
        "show route"
    end



end