class SchoolStudentsController < ApplicationController
  def index
    @school = School.find(params[:id])
    @students = @school.students
  end
end
