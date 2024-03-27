class StudentsController < ApplicationController
  def index
    @students = Student.where(currently_enrolled: true)
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    Student.find(params[:id]).update(
      name: params["student-name"],
      age: params["student-age"],
      currently_enrolled: params["student-enrolled"],
      account_balance: params["student-balance"]
    )

    redirect_to("/students/#{params[:id]}")
  end

  def destroy
    Student.find(params[:id]).destroy

    redirect_to("/students")
  end
end
