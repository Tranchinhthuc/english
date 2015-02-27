class Supervisor::SubjectsController < ApplicationController
  before_action :supervisor
  respond_to :html, :js

  def index
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save
    redirect_to supervisor_course_path(@subject.course)
  end

  def addtask
    @subject = Subject.find(params[:subject_id])
    @tasks = @subject.tasks
    @task = Task.new
  end

  def show
    @subject = Subject.find(params[:id])
    #@subjects = @course.subjects
    @tasks = @subject.tasks
    @task = Task.new
  end

  def edit
    @subject = Subject.find(params[:id])
    @subjects = @subject.course.subjects
    #@subject = Subject.new
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update_attributes(subject_params)
    redirect_to supervisor_course_path @subject.course
  end

  def destroy
    @subject = Subject.find(params[:id])
    @course = @subject.course
    @subject.destroy
    redirect_to supervisor_course_path @course
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :description, :course_id,
      :tasks_attributes => [:id, :description])
  end

  def supervisor
    if logged_in?
      unless current_user.is_supervisor?
        flash[:danger] = "You must be supervisor"
        redirect_to(root_url)
      end
    else
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end    
  end
end
