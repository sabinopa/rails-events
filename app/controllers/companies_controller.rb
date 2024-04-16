class CompaniesController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]
  before_action :force_company_creation_for_suppliers, only: [:show]

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_supplier.build_company(company_params)
    if @company.save
      flash[:notice] = t('.success', brand_name: @company.brand_name)
      redirect_to company_path(@company)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:owner_id,:brand_name, :corporate_name, :registration_number,
                                    :phone_number, :email, :address, :neighborhood, :city,
                                    :state, :zipcode, :description, payment_method_ids: [])
  end
end