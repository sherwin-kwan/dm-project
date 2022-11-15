class PeopleController < ApplicationController
  def show
    @person = Person.find_by(id: params[:id].to_i)
    unless @person
      render :error, status: 404 and return
    end
  end
end