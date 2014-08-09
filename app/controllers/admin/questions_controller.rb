class Admin::QuestionsController < ApplicationController
  def create
    flash[:notice] = "Successfully created question" if @guard.create_question(question_params)
    redirect_to admin_home_path
  end
  
  private
    def question_params
      params.require(:question).permit(:question, :question_type)
    end
  
end
