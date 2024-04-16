class HomeController < ApplicationController
  before_action :force_company_creation_for_suppliers, only: [:index]

  def index
  end
end