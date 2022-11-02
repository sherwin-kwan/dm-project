module Admin
  class PeopleController < ApplicationController
    def edit
      @person = get_object
    end

    def update
      @person = get_object
      if @person.update(permitted_params)
        redirect_to admin_dashboard_path(@person.user.id)
      else
        flash[:errors] = "People could not be updated, #{@person.errors&.full_messages}"
        render :edit, status: 400
      end
    end

    def permitted_params
      params.require(:person).permit(:name, :given_name, :display_name, :date_of_birth, :country, :city, :fb_name, :li_name, :tw_name, :ig_name,
      :bio, :slogan, :gender)
    end
  end
end