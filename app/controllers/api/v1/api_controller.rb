class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404

  private

  def return_500
    render status: 500, json: { errors: 'Ocorreu um erro no servidor.' }
  end

  def return_404
    render status: 404, json: { errors: 'O id informado não foi encontrado.' }
  end
end