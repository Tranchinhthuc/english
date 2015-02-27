class ChoiceQuestionsController < ApplicationController
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
    @test = @choice_question.test
    @choice_question.destroy
    redirect_to supervisor_test_path @test
  end

  private

  def choice_question_params
    params.require(:choice_question).permit(:test_id, :content, :number,
       :answers_attributes => [:id, :akey, :bkey, :ckey, :dkey, :correctkey])
  end
end
