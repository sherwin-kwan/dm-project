module Admin
  class PeopleController < ApplicationController
    def edit
      if current_user
        @person = Person.find_by(id: current_user.person&.id)
        unless @person
          render :error, status: 404 and return
        end
      else
        flash[:errors] = "You are not authorized to view this page"
        redirect_to admin_dashboard_path
      end
    end

    def update
      if current_user
        @person = Person.find_by(id: current_user.person&.id)
        unless @person
          render :error, status: 404 and return
        end
        if @person.update(permitted_params)
          redirect_to admin_dashboard_path
        else
          flash[:errors] = "People could not be updated, #{@person.errors&.full_messages}"
          render :edit, status: 400
        end
      else
        flash[:errors] = "You are not authorized to view this page"
        redirect_to admin_dashboard_path
      end
    end

    def permitted_params
      params.require(:person).permit(:name, :given_name, :display_name, :date_of_birth, :country, :city, :fb_name, :li_name, :tw_name, :ig_name,
      :bio, :slogan, :gender)
    end
  end
end