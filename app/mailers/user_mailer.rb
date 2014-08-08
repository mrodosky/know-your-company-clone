class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def owner_welcome(owner, generated_password)
    @owner = owner
    @generated_password = generated_password
    mail(to: @owner.email, subject: 'Welcome to My Awesome Site')
  end
  
end
