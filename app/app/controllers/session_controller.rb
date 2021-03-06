class SessionController < ApplicationController

    def new
        render layout: false
    end

    def create
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_url
        else
            flash[:alert] = "Username or password is invalid"
            redirect_to login_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end

end
