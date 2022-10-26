class PeopleController < ApplicationController
  def show
    @person = get_object
  end
end