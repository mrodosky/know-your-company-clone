class Guard

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
    if admin?
      owner_params[:users_attributes].each do |key, user_params|
        generated_password = Devise.friendly_token.first(8)
        owner_params[:users_attributes][key][:password] = generated_password
        owner_params[:users_attributes][key][:role] = "owner"
        user = User.new(owner_params[:users_attributes][key])
        UserMailer.owner_welcome(user, generated_password).deliver if user.valid?
      end
      company.update_attributes(owner_params)
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