class SchoolsController < ApplicationController
  def index
    @schools = School.chronological
  end

  def show
    @school = School.find(params[:id])
  end
end
