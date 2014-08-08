class UserService
  def self.invite_user(params, generated_password)
    user = User.new(params)
    UserMailer.employee_welcome(user, generated_password).deliver if user.valid?
  end
  
end