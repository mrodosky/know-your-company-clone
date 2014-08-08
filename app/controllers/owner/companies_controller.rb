class Owner::CompaniesController < ApplicationController
  def show
    @company = @guard.fetch_company
  end
end
