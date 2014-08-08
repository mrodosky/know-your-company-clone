class UserService
  def self.add_and_invite_user(params, generated_password, type)
    user = User.create!(params)
    UserMailer.send("#{type}_welcome", user, generated_password).deliver if user.valid?
  end
  
end