class Question < ActiveRecord::Base
  
  def self.first_serious_question
    where('user_id IS NULL').where(question_type: 'serious').order(:created_at).first
  end
  
  def self.first_fun_question
    where('user_id IS NULL').where(question_type: 'fun').order(:created_at).first
  end
  
  def self.next_serious_question_id(question_id)
    begin
      where('user_id IS NULL').where(question_type: 'serious').where('id > ?', question_id).order("id ASC").first.id
    rescue
      where('user_id IS NULL').where(question_type: 'serious').first.id
    end
  end

  def self.next_fun_question_id(question_id)
    begin
      where('user_id IS NULL').where(question_type: 'fun').where('id > ?', question_id).order("id ASC").first.id
    rescue
      where('user_id IS NULL').where(question_type: 'fun').first.id
    end
  end
  
  def previous_fun_question(question_id)
    begin
      where('user_id IS NULL').where(question_type: 'fun').where('id < ?', question_id).order("id DESC").first
    rescue
      where('user_id IS NULL').where(question_type: 'fun').last
    end
  end

  def previous_serious_question(question_id)
    begin
      where('user_id IS NULL').where(question_type: 'serious').where('id < ?', question_id).order("id DESC").first
    rescue
      where('user_id IS NULL').where(question_type: 'serious').last
    end
  end
  
  
end
