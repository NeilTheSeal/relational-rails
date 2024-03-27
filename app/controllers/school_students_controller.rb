class SchoolStudentsController < ApplicationController
  def index
    @school = School.find(params[:id])
    @students = if params[:age].nil?
                  @school.students
                else
                  @school.students.where("age >= #{params[:age]}")
                end

    return unless params[:alphabetical] == "true"

    @students = @students.alphabetical
  end

  def new
    @school = School.find(params[:id])
  end

  def create
    @school = School.find(params[:id])
    @school.students.create!(school_student_params)

    redirect_to("/schools/#{@school.id}/students")
  end

  private

  def school_student_params
    params.permit(:name, :age, :account_balance, :currently_enrolled)
  end
end
