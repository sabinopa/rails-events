class Api::V1::EventTypesController < Api::V1::ApiController

  def index
    @company = Company.find(params[:company_id])
    @event_types = @company.event_types

    render status: 200, json: @event_types.as_json(except: [:created_at, :updated_at])
  end

  def check_availability

  end
end