class AdminController < ApplicationController
  def home
    @companies = @guard.companies
    @questions = @guard.questions
  end
end
