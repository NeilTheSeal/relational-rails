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
    Student.find(params[:id]).update(
      name: params[:name],
      age: params[:age],
      currently_enrolled: params[:currently_enrolled],
      account_balance: params[:account_balance]
    )

    redirect_to("/students/#{params[:id]}")
  end

  def destroy
    Student.find(params[:id]).destroy

    redirect_to("/students")
  end
end
