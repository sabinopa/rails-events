class Api::V1::EventTypesController < Api::V1::ApiController

  def index
    @company = Company.find(params[:company_id])
    @event_types = @company.event_types

    render status: 200, json: @event_types.as_json(except: [:created_at, :updated_at])
  end

  def availability
    company = Company.find(params[:company_id])
    event_type = EventType.find(params[:id])
    number_attendees = params[:number_attendees].to_i
    day_type = params[:day_type]

    if params[:date].blank? || params[:number_attendees].blank? || day_type.blank?
      render status: 400, json: { error: I18n.t('errors.messages.missing_date_attendees_day_type') }
      return
    end

    date = Date.parse(params[:date]) rescue nil
    unless date
      render status: 400, json: { error: I18n.t('errors.messages.invalid_date_format') }
      return
    end

    if date < Date.today
      render status: 406, json: { error: I18n.t('errors.messages.invalid_date_format') }
      return
    end

    if number_attendees < event_type.min_attendees || number_attendees > event_type.max_attendees
      render status: 406, json: { error: I18n.t('errors.messages.attendees_out_of_range') }
      return
    end

    if Order.where(company_id: company.id, event_type: event_type, date: date, status: [:negotiating, :order_confirmed]).exists?
      render status: 406, json: { error: I18n.t('errors.messages.no_availability_for_date') }
      return
    end

    base_price = event_type.calculate_base_price(day_type, number_attendees)

    render status: 200, json: { available: true, estimated_price: base_price }
  end
end
