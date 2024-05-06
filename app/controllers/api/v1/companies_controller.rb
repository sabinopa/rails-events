class Api::V1::CompaniesController < ActionController::API

  def show
    @company = Company.find(params[:id])
    render status: 200, json: @company.as_json({except: [:created_at, :updated_at, :registration_number, :corporate_name]})
  end
end