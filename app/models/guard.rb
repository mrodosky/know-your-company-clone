class Guard
  
  require 'user_service'
  
  def initialize(user)
    @user = user
  end

  def companies
    admin? ? Company.all : Company.find(@user.company_id)
  end
  
  def new_company
    admin? ? Company.new : nil
  end
  
  def create_company(company_params)
    admin? ? Company.create(company_params) : (raise "Not Allowed to create company")
  end

  def find_company(id)
    Company.find(id) if admin?
  end
  
  def fetch_company
    Company.find(@user.company_id) if owner?
  end
  
  def add_owners_and_send_email(company, owner_params)
    add_users_to_company(company, owner_params, :owner) if admin?
  end
  
  def add_employees_and_send_email(employee_params)
    add_users_to_company(fetch_company, employee_params, :employee) if owner?
  end
  
  def add_users_to_company(company, params, type)
    params[:users_attributes].keys.each do |key|
      generated_password = Devise.friendly_token.first(8)
      params[:users_attributes][key][:password] = generated_password
      params[:users_attributes][key][:role] = type
      params[:users_attributes][key][:company_id] = company.id
      UserService.add_and_invite_user(params[:users_attributes][key], generated_password, type)
    end
  end
  
  private

    def admin?
      @user.is_admin?
    end

    def owner?
      @user.is_owner?
    end

end