class RemoveTypeFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :type
  end
end
