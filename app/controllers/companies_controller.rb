class CompaniesController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]

  def new
  end

  def create
  end
end