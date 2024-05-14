class CompaniesController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update, :active, :inactive]
  before_action :force_company_creation_for_owners, only: [:show, :search, :edit, :update]
  before_action :set_company, only: [:show, :edit, :update, :active, :inactive]
  before_action :check_owner, only: [:edit, :update]

  def show
    unless @company.active? || (owner_signed_in? && current_owner == @company.owner)
      flash[:alert] = t('.not_available')
      redirect_to root_path and return
    end

    @event_types = @company.event_types
    unless owner_signed_in? && current_owner == @company.owner
      @event_types = @event_types.active
    end

    if @company.reviews.present?
      @reviews = @company.reviews.last(3)
      @average_score = @company.reviews.average(:score).to_f.round(2)
    else
      @reviews = []
      @average_score = 0
    end
  end

  def new
    if current_owner.company.present?
      flash[:alert] = t('.error')
      redirect_to root_path
    end
    @company = Company.new
  end

  def create
    @company = current_owner.build_company(company_params)
    if @company.save
      flash[:notice] = t('.success', brand_name: @company.brand_name)
      redirect_to company_path(@company)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      flash[:notice] = t('.success', brand_name: @company.brand_name)
      redirect_to @company
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  def search
    @query_params = params["query"]
    @companies = Company.search(@query_params)
  end

  def active
    @company.active!
    flash[:notice] = t('.success')
    redirect_to @company
  end

  def inactive
    @company.inactive!
    flash[:alert] = t('.success')
    redirect_to @company
  end

  private

  def company_params
    params.require(:company).permit(:owner_id,:brand_name, :corporate_name, :registration_number,
                                    :phone_number, :email, :address, :neighborhood, :city,
                                    :state, :zipcode, :description, payment_method_ids: [])
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def check_owner
    @company = Company.find(params[:id])
    if current_owner != @company.owner
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end