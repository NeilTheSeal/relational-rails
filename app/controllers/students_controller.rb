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
    # For some reason, strong params doesn't work here
    # It does not updated :currently_enrolled using strong params
    # but does with the syntax below. I think it has something
    # to do with using a checkbox...

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
