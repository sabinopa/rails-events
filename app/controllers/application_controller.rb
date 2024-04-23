class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname, :email, :document_number, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname, :email, :document_number, :password, :password_confirmation, :current_password])
  end

  def force_company_creation_for_suppliers
    if supplier_signed_in? && current_supplier.company.nil?
      flash[:alert] = I18n.t('actions.force_company_creation_for_suppliers.redirect')
      redirect_to new_company_path
    end
  end
end
