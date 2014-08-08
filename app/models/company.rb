class Company < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users
  
  def employees
    users.select {|u| u.is_employee?}
  end
  
end
