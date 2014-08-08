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
      admin_companies_path if resource.is_admin?
      owner_company_path if resource.is_owner?
    end
  
end
