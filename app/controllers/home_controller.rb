class HomeController < ApplicationController
  before_action :force_company_creation_for_owners, only: [:index]

  def index
    if owner_signed_in?
      @company = current_owner.company
    else
      @companies = Company.active
    end
  end
end
