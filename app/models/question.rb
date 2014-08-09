class Question < ActiveRecord::Base
  
  def self.first_serious_question
    where('user_id IS NULL').where(question_type: 'serious').order(:created_at).first
  end
  
  def self.first_fun_question
    where('user_id IS NULL').where(question_type: 'fun').order(:created_at).first
  end
  
  def self.next_serious_question_id(question_id)
    begin
      first_sorted_question("serious", question_id, "ASC").id
    rescue
      where('user_id IS NULL').where(question_type: 'serious').first.id
    end
  end

  def self.next_fun_question_id(question_id)
    begin
      first_sorted_question("fun", question_id, "ASC").id
    rescue
      where('user_id IS NULL').where(question_type: 'fun').first.id
    end
  end
  
  def self.previous_fun_question(question_id)
    question = first_sorted_question("fun", question_id, "DESC")
    return question unless question.nil?
    where('user_id IS NULL').where(question_type: 'fun').last
  end

  def self.previous_serious_question(question_id)
    question = first_sorted_question("serious", question_id, "DESC")
    return question unless question.nil?
    where('user_id IS NULL').where(question_type: 'serious').last
  end
  
  def self.first_sorted_question(question_type, question_id, order)
    where('user_id IS NULL').where(question_type: question_type).where('id < ?', question_id).order("id #{order}").first
  end
  
  
end
