class Supervisor::TestsController < ApplicationController
  before_action :supervisor
  respond_to :html, :js

  def index
  end

  def new
    @test = Test.new
    3.times do
      choice_question = @test.choice_questions.build
      1.times { choice_question.answers.build }
    end
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

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to supervisor_task_path @test.task
    else
      render 'new'
    end
  end

  def show
    @test = Test.find(params[:id])
    @choice_questions = @test.choice_questions
    @choice_question = ChoiceQuestion.new
  end

  def edit
    @test = test.find(params[:id])
    @tests = @test.course.tests
    #@test = test.new
  end

  def update
    @test = test.find(params[:id])
    @test.update_attributes(test_params)
    redirect_to supervisor_course_path @test.course
  end

  def destroy
    @test = Test.find(params[:id])
    @task = @test.task
    @test.destroy
    redirect_to supervisor_task_path @task
  end

  private

  def test_params
    params.require(:test).permit(:name, :task_id,
      :choice_questions_attributes => [:id, :content, :number,
       :answers_attributes => [:id, :akey, :bkey, :ckey, :dkey, :correctkey]])
  end
  def choice_question_params
    params.require(:choice_question).permit(:test_id, :content, :number,
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
