class Company < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users
  
  def employees
    users.select { |u| u.is_employee? }
  end
  
  def owners
    users.select { |u| u.is_owner? }
  end
  
end
