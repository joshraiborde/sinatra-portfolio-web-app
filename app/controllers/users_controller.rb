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
            flash[:message] = "Welcome, #{@user.name}!"
            redirect "users/#{@user.id}"
        else
            flash[:errors] = "Invalid credentials. Please Sign Up or try again"
            redirect '/login'
        end
    end

    #signup form
    get '/signup' do
        erb :signup 
    end

    post '/users' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Congrats! #{user.name}, you have created a Devotions Account!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Uh-Oh. Account creation was a failure... #{user.errors.full_messages.to_sentence}"
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