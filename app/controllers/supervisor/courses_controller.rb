class Supervisor::CoursesController < ApplicationController
  before_action :supervisor
  respond_to :html, :js
  
  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
    @subject = Subject.new
  end

  def create
    @course = Course.new(course_params)
    @course.save
    redirect_to supervisor_courses_path
  end

  def show
    @course = Course.find(params[:id])
    @subjects = @course.subjects
    @subject = Subject.new
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to supervisor_courses_path
  end

  def addsubject
    @course = Course.find(params[:course_id])
    @subjects = @course.subjects
    @subject = Subject.new
  end

  def edit
    @course = Course.find(params[:id])
    #@subjects = @course.subjects
    @subject = Subject.new
    #@subject = @course.subjects
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes(course_params)
    redirect_to supervisor_course_path @course
  end

  private

  def course_params
    params.require(:course).permit(:name, :description,
      :subjects_attributes => [:id, :description, :name])   
  end

  def subject_params
    params.require(:subject).permit(:name, :course_id,
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
