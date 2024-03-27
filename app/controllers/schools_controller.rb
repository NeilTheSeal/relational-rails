class SchoolsController < ApplicationController
  def index
    @schools = School.chronological
  end

  def show
    @school = School.find(params[:id])
  end

  def new; end

  def create
    School.create!(school_params)

    redirect_to("/schools")
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    School.find(params[:id]).update(
      name: params[:name],
      location: params[:location],
      abet_accredited: params[:abet_accredited],
      student_capacity: params[:student_capacity]
    )

    redirect_to("/schools/#{params[:id]}")
  end

  def destroy
    Student.where("school_id = ?", params[:id]).destroy_all
    School.find(params[:id]).destroy

    redirect_to("/schools")
  end

  private

  def school_params
    params.permit(:name, :location, :abet_accredited, :student_capacity)
  end
end
