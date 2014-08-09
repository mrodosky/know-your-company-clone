class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :enable_guard
  before_action :authenticate_user!

  def enable_guard
    @guard = Guard.new(current_user)
  end
  
  protected 
    def after_sign_in_path_for(resource)
      if resource.is_admin?
        admin_home_path 
      elsif resource.is_owner?
        owner_company_path
      elsif resource.is_employee?
        employee_questions_path
      end
    end
  
end
