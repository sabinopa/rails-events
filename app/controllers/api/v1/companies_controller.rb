class Api::V1::CompaniesController < Api::V1::ApiController
  def index
    @companies = Company.active
    @companies = @companies.where('brand_name LIKE ?', "%#{params[:name]}%") if params[:name]

    render status: 200,
           json: @companies.as_json({ except: %i[created_at updated_at registration_number corporate_name] })
  end

  # def create
  #   company_params = params.require(:company).permit(:brand_name, :corporate_name,
  #                                                    :registration_number, :phone_number,
  #                                                    :email, :address, :neighborhood,
  #                                                    :city, :state, :zipcode, :description)
  #   company = Company.new(company_params)

  #   company.owner_id ||= 1

  #   if company.save(validate: false)
  #     render status: 201, json: company
  #   else
  #     render status: 412, json: { errors: company.errors.full_messages }
  #   end
  # end

  def search
    query = params[:query]
    @companies = if query.present?
                   Company.active.left_joins(:event_types)
                          .where('companies.brand_name LIKE :query OR companies.city LIKE :query
                                OR event_types.name LIKE :query', query: "%#{query}%").distinct.order(:brand_name)
                 else
                   Company.active.order(:brand_name)
                 end

    render status: 200,
           json: @companies.as_json({ except: %i[created_at updated_at registration_number corporate_name] })
  end

  def show
    @company = Company.active.find_by(id: params[:id])
    if @company
      response_json = @company.as_json(
        except: %i[created_at updated_at registration_number corporate_name],
        methods: [:average_score]
      )
      render json: response_json, status: 200
    else
      render json: { errors: I18n.t('errors.messages.not_found') }, status: 404
    end
  end
end
