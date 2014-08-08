class StaticController < ApplicationController
  def home
    redirect_to admin_companies_path if current_user.try(:is_admin?)
  end
end
