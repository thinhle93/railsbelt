class UsersController < ApplicationController
    skip_before_action :require_login, only: [:index, :register, :login]
    def index   

    end

    def register
        user = User.create(user_params)

        if !user.valid?
            flash[:errors] = user.errors.full_messages
           
            redirect_to "/"
        else
           
            session[:userid] = user.id
            redirect_to "/users/find/#{session[:userid]}"
        end
    end

    def show_user
        @user = User.find(params[:id])
        @organizations = Organization.all
        @userorgs = @user.organization_ids
    end

    def logout
        session[:userid] = nil
        redirect_to '/'
    end

    def login
        u = User.find_by(email: params[:email])
        
        if u && u.authenticate(params[:password])
            session[:userid] = u.id 
            redirect_to "/users/find/#{session[:userid]}"
        else
            flash[:errors] = ["Invalid Log in"]
            redirect_to "/"
        end 
    end


    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)

    end
end
