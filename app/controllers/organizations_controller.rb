class OrganizationsController < ApplicationController

    def create_org
        org = Organization.create(org_params)

        if !org.valid?
            flash[:errors] = org.errors.full_messages
        else
            Join.create(user_id: session[:userid], organization_id: org.id)
        end
        redirect_to "/users/find/#{session[:userid]}"
    end

    def show_org
        @org = Organization.find(params[:id])
        @owner = @org.user
        @members = @org.attendance
        @members_ids = @org.attendance_ids
    end

    def join_org
        Join.create(user_id:session[:userid], organization_id: params[:id])
        redirect_to "/users/find/#{session[:userid]}"
    end

    def unjoin_org
        unjoin = Join.find_by(user_id:session[:userid], organization:params[:id])
        unjoin.destroy
        redirect_to "/users/find/#{session[:userid]}"
    end

    def delete
        org = Organization.find(params[:id])
        org.destroy
        redirect_to "/users/find/#{session[:userid]}"
    end


    private
        def org_params
            params.require(:org).permit(:name, :description, :user_id)
        end
end
