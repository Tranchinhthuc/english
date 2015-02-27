class Supervisor::TasksController < ApplicationController
  before_action :supervisor
  respond_to :html, :js
  def index
  end

  def new
    @task = Task.new
  end

  def addtest
    @test = Test.new
    1.times do
      choice_question = @test.choice_questions.build
      1.times { choice_question.answers.build }
    end
    @task = Task.find(params[:task_id])
    @tests = @task.tests
    #@test = Test.new
  end

  def addquestion

    @question = ChoiceQuestion.new
    1.times do 
      @question.answers.build
    end
    @test = Test.find(params[:test_id])
    @questions = @test.choice_questions
    #@test = Test.new
  end

  def show
    @task = Task.find(params[:id])
    @tests = @task.tests
    @test = Test.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    #redirect_back_or root_path
    redirect_to supervisor_task_path @task
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to supervisor_subject_path(@task.subject)
  end

  def destroy
    @task = Task.find(params[:id])
    @subject = @task.subject
    @task.destroy
    redirect_to supervisor_subject_path @subject
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :subject_id,
      :test_attributes => [:id, :name, :choice_questions_attributes => [:id, :content, :number,
       :answers_attributes => [:id, :akey, :bkey, :ckey, :dkey, :correctkey]]])
  end

  def question_params
    params.require(:choice_question).permit(:content, :number,
       :answers_attributes => [:id, :akey, :bkey, :ckey, :dkey, :correctkey])
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
