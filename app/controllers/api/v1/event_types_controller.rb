class Api::V1::EventTypesController < Api::V1::ApiController
  def index
    @company = Company.find(params[:company_id])
    @event_types = @company.event_types.active.includes(:event_pricings)

    render status: 200, json: @event_types.as_json(include: :event_pricings, except: %i[created_at updated_at])
  end

  def availability
    set_availability

    return unless check_params && check_date && check_attendees && check_availability

    base_price = @event_type.calculate_base_price(@day_type, @number_attendees)
    render status: 200, json: { available: true, estimated_price: base_price }
  end

  private

  def set_availability
    @company = Company.find(params[:company_id])
    @event_type = EventType.find(params[:id])
    @number_attendees = params[:number_attendees].to_i
    @day_type = params[:day_type]
  end

  def check_params
    if params[:date].blank? || params[:number_attendees].blank? || @day_type.blank?
      render status: 400, json: { error: I18n.t('errors.messages.missing_date_attendees_day_type', locale: :'pt-BR') }
      false
    else
      true
    end
  end

  def check_date
    @date = Date.parse(params[:date])
    if @date < Date.today
      render status: 406, json: { error: I18n.t('errors.messages.invalid_date_format', locale: :'pt-BR') }
      false
    else
      true
    end
  rescue ArgumentError
    render status: 400, json: { error: I18n.t('errors.messages.invalid_date_format', locale: :'pt-BR') }
    false
  end

  def check_attendees
    if @number_attendees < @event_type.min_attendees || @number_attendees > @event_type.max_attendees
      render status: 406, json: { error: I18n.t('errors.messages.attendees_out_of_range', locale: :'pt-BR') }
      false
    else
      true
    end
  end

  def check_availability
    if Order.where(
      company_id: @company.id, event_type: @event_type.id,
      date: @date, status: %i[negotiating order_confirmed]
    ).exists?
      render status: 406, json: { error: I18n.t('errors.messages.no_availability_for_date', locale: :'pt-BR') }
      false
    else
      true
    end
  end
end
