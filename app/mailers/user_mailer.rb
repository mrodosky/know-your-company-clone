class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def owner_welcome(owner, generated_password)
    @owner = owner
    @generated_password = generated_password
    mail(to: @owner.email, subject: 'Welcome to My Awesome Site')
  end
  
  def employee_welcome(employee, generated_password)
    @employee = employee
    @generated_password = generated_password
    mail(to: @employee.email, subject: 'Welcome to My Awesome Site')
  end
  
  def share_work_details(employee, question)
    @employee = employee
    @question = question
    mail(to: @employee.email, subject: 'Colleague Work Details')
  end
  
  def ask_serious_question(employee, question)
    @employee = employee 
    @question = question
    mail(to: @employee.email, subject: 'Got a Minute?')
  end
  
  def ask_fun_question(employee, question)
    @employee = employee
    @question = question
    mail(to: @employee.email, subject: 'Share something about yourself!')
  end
  
  def send_fun_answers(employee, question, employee_answers)
    @employee = employee
    @question = question
    @employee_answers = employee_answers
    mail(to: @employee.email, subject: "Here's what your colleagues said last week!")
  end
  
  def send_serious_answers(owner, question, employee_answers)
    @owner = owner
    @question = question
    @employee_answers = employee_answers
    mail(to: @owner.email, subject: "Here's what your employees said last week!")
  end
  
end
