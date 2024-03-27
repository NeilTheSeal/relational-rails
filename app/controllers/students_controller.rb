class StudentsController < ApplicationController
  def index
    @students = Student.enrolled
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    Student.find(params[:id]).update(student_params)

    redirect_to("/students/#{params[:id]}")
  end

  def destroy
    Student.find(params[:id]).destroy

    redirect_to("/students")
  end

  private

  def student_params
    params.permit(:name, :age, :currently_enrolled, :account_balance)
  end
end
