class Supervisor::ChoiceQuestionsController < ApplicationController
  before_action :supervisor
  respond_to :html, :js

  def index
  end

  def new
    @choice_question = ChoiceQuestion.new
    choice_question.answers.build
  end

  def create
    @choice_question = ChoiceQuestion.new(choice_question_params)
    if @choice_question.save
      redirect_to test_path @choice_question.test
    else
      render 'new'
    end
  end

  def show
    @choice_question = ChoiceQuestion.find(params[:id])
    @answers = @choice_question.answers
    @answer = Answer.new
  end

  def edit
    @question = ChoiceQuestion.find(params[:id])
    @answers = @question.answers
    #@test = test.new
  end

  def update
    @question = ChoiceQuestion.find(params[:id])
    @question.update_attributes(choice_question_params)
    redirect_to test_path @question.test
  end

  def destroy
    @choice_question = ChoiceQuestion.find(params[:id])
    @choice_question.destroy
    redirect_to supervisor_test_path @choice_question.test
  end

  private

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
