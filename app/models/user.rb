class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def is_admin?
   role == 'admin'
  end

  def is_owner?
   role == 'owner'
  end
  
  def is_employee?
    role == 'employee'
  end
  
end
