class Owner::CompaniesController < ApplicationController
  def show
    @company = @guard.fetch_company
  end
  
  def add_employee
    company = @guard.fetch_company
    flash[:notice] = "Successfully added employee(s)" if @guard.add_employees_and_send_email(employee_params)
    redirect_to owner_company_path
  end
  
  private
    def employee_params
      params.require(:company).permit(users_attributes: [:id, :email, :_destroy])
    end
  
end
