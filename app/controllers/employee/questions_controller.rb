class Employee::QuestionsController < ApplicationController
  def index
    @questions = @guard.fetch_questions
  end
  
  def answer_question
    db_question = @guard.fetch_question(params[:question_id])
    #duplicate questions are allowed in case user is asked the same question after a time gap
    @question = @guard.create_question({question: db_question.question, user_id: @guard.user.id})
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
