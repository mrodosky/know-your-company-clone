class AddQuestionToAskToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :serious_question_to_ask, :text
    add_column :companies, :fun_question_to_ask, :text
  end
end
