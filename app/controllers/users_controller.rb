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
            flash[:message] = "Welcome, #{@user.name.capitalize}!"
            redirect "users/#{@user.id}"
        else
            flash[:errors] = "Uh-oh. Either the Email or Password is incorrect. Please try again or Sign Up."
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
            flash[:message] = "Congrats! #{@user.name}, you have created a Devotions Account!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Uh-Oh. We weren't able to make an account because #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'	
        end
    end

    #show route
    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in

        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end


end