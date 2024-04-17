class HomeController < ApplicationController
  before_action :force_company_creation_for_suppliers, only: [:index]

  def index
    if supplier_signed_in?
      @company = current_supplier.company
    end
    @event_types = EventType.all
  end
end