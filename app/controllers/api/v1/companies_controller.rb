class Api::V1::CompaniesController < Api::V1::ApiController

  def index
    @companies = Company.all
    if params[:search].present?
      @companies = Company.where('brand_name ILIKE ?', "%#{params[:search]}%")
    end
    render status: 200, json: @companies.as_json({ except: [:created_at, :updated_at, :registration_number, :corporate_name] })
  end

  def show
    @company = Company.find(params[:id])
    render status: 200, json: @company.as_json({ except: [:created_at, :updated_at, :registration_number, :corporate_name] })
  end
end