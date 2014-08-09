class Employee::QuestionsController < ApplicationController
  def index
    @questions = @guard.fetch_questions
  end
  
  def answer_question
    @question = @guard.fetch_question(params[:question_id])
  end
  
  def update
    @question = @guard.fetch_question(params[:id])
    flash[:notice] = "Successfully Updated Question" if @guard.update_question(@question, question_params)
    redirect_to employee_questions_path
  end
  
  private

  def question_params
    params.require(:question).permit(:answer)
  end
  
end
