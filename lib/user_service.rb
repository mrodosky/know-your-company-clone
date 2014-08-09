class UserService
  def self.add_and_invite_user(params, generated_password, type)
    user = User.create!(params)
    UserMailer.send("#{type}_welcome", user, generated_password).deliver if user.valid?
  end
  
  def self.send_work_details_email
    #every employee gets this email
    question_text = "What are you working on?"
    User.where(role: 'employee').each do |user|
      question = user.questions.create!(question: question_text)
      UserMailer.share_work_details(user, question).deliver
    end
  end
  
  def self.send_serious_email(company)
    question_id = company.serious_question_to_ask
    question_id = Question.first_serious_question unless question_id
    question = Question.find(question_id)

    company.employees.each do |employee|
      employee_question = employee.questions.create!(question: question.question,
                                                     question_type: question.question_type)
      UserMailer.ask_serious_question(employee, employee_question).deliver
    end

    company.serious_question_to_ask = Question.next_serious_question_id(question_id)
    company.save!
  end
  
  def self.send_fun_email(company)
    question_id = company.fun_question_to_ask
    question_id = Question.first_fun_question unless question_id
    question = Question.find(question_id)
    
    company.employees.each do |employee|
      employee_question = employee.questions.create!(question: question.question,
                                            question_type: question.question_type)
      UserMailer.ask_fun_question(employee, employee_question).deliver
    end
    
    company.fun_question_to_ask = Question.next_fun_question_id(question_id)
    company.save!
    
  end
  
  def self.send_fun_answers(company)
    question = Question.previous_fun_question(company.fun_question_to_ask)
    employee_answers = {}
    company.employees.each do |employee|
      employee_question = employee.questions.where(question: question.question).order('created_at DESC').first #same question will likely repeat itself
      employee_answers[employee.email] = employee_question.answer
    end
    
    company.employees.each do |employee|
      UserMailer.send_fun_answers(employee, question, employee_answers)
    end
    
  end
  
  def self.send_serious_answers(company)
    question = Question.previous_serious_question(company.serious_question_to_ask)
    employee_answers = {}
    company.employees.each do |employee|
      employee_question = employee.questions.where(question: question.question).order('created_at DESC').first #same question will likely repeat itself
      employee_answers[employee.email] = employee_question.answer
    end
    
    company.owners.each do |owner|
      UserMailer.send_serious_answers(owner, question, employee_answers)
    end
    
  end
  
end