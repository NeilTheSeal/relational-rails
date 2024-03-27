class SchoolStudentsController < ApplicationController
  def index
    @school = School.find(params[:id])
    @students = if params["student-age"].nil?
                  @school.students
                else
                  @school.students.where("age >= #{params['student-age']}")
                end

    return unless params[:alphabetical] == "true"

    @students = @students.order("name ASC")
  end

  def new
    @school = School.find(params[:id])
  end

  def create
    @school = School.find(params[:id])
    @school.students.create!(
      name: params["student-name"],
      age: params["student-age"],
      account_balance: params["student-balance"],
      currently_enrolled: params["student-enrolled"]
    )

    redirect_to("/schools/#{@school.id}/students")
  end
end
