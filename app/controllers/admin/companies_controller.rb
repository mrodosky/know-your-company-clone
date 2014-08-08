class Admin::CompaniesController < ApplicationController
  def new
    @company = @guard.new_company
  end
  
  def create
    @guard.create_company(company_params)
    redirect_to admin_companies_path
  end
  
  def index
    @companies = @guard.companies
  end
  
  def show
    @company = @guard.find_company(params[:id])
  end
  
  def add_owner
  end
  
  def update
    company = @guard.find_company(params[:id])
    #TODO: should be moved into add_owner action instead of being here in generic update
    flash[:notice] = "Successfully added owner(s)" if @guard.add_owners_and_send_email(company, owner_params)
    redirect_to admin_company_path(company)
  end

  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def company_params
      params.require(:company).permit(:name)
    end
    
    def owner_params
      params.require(:company).permit(users_attributes: [:id, :email, :_destroy])
    end
  
end
