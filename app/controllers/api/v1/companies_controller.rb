class Api::V1::CompaniesController < Api::V1::ApiController

  def index
    @companies = Company.active
    @companies = @companies.where("brand_name LIKE ?", "%#{params[:name]}%") if params[:name]

    render status: 200, json: @companies.as_json({ except: [:created_at, :updated_at, :registration_number, :corporate_name] })
  end

  def search
    query = params[:query]
    if query.present?
      @companies = Company.active.left_joins(:event_types)
                          .where("companies.brand_name LIKE :query OR companies.city LIKE :query OR event_types.name LIKE :query", query: "%#{query}%")
                          .distinct.order(:brand_name)
    else
      @companies = Company.active.order(:brand_name)
    end

    render status: 200, json: @companies.as_json({ except: [:created_at, :updated_at, :registration_number, :corporate_name] })
  end

  def show
    @company = Company.active.find(params[:id])
    if @company
      response_json = @company.as_json(
        except: [:created_at, :updated_at, :registration_number, :corporate_name],
        methods: [:average_score]
      )
      render json: response_json, status: 200
    else
      render json: { errors: I18n.t('errors.messages.not_found') }, status: 404
    end
  end
end