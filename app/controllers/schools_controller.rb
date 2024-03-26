class SchoolsController < ApplicationController
  def index
    @schools = School.chronological
  end

  def show
    @school = School.find(params[:id])
  end

  def new; end

  def create
    School.create!(
      name: params["school-name"],
      location: params["school-location"],
      abet_accredited: params["school-accredited"],
      student_capacity: params["school-capacity"]
    )

    redirect_to("/schools")
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    School.find(params[:id]).update(
      name: params["school-name"],
      location: params["school-location"],
      abet_accredited: params["school-accredited"],
      student_capacity: params["school-capacity"]
    )

    redirect_to("/schools/#{params[:id]}")
  end
end
