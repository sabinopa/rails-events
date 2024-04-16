class CompaniesController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create, :edit, :update]
  before_action :force_company_creation_for_suppliers, only: [:show, :edit, :update]
  before_action :check_owner, only: [:edit, :update]

  def show
    @company = Company.find(params[:id])
    @supplier = current_supplier
  end

  def new
    if current_supplier.company.present?
      flash[:alert] = t('.error')
      redirect_to root_path
    end
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

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:notice] = t('.success', brand_name: @company.brand_name)
      redirect_to @company
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:owner_id,:brand_name, :corporate_name, :registration_number,
                                    :phone_number, :email, :address, :neighborhood, :city,
                                    :state, :zipcode, :description, payment_method_ids: [])
  end

  def check_owner
    @company = Company.find(params[:id])
    if current_supplier != @company.supplier
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end

end