class UsersController < ApplicationController

    #login page
    get '/login' do
        erb :login
    end

    #login form
    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts session
            redirect "users/#{@user.id}"
        else
            flash[:message] = "Invalid credentials. Please Sign Up or try again"
            redirect '/login'
        end
    end

    #signup form
    get '/signup' do
        erb :signup 
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
            else
            redirect '/signup'	
        end        
    end

    #show route
    get '/users/:id' do
        @user = User.find_by(id: params[:id])

        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end


end