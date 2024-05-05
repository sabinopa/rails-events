module ApplicationHelper
  def format_currency(value)
    number_to_currency(value, locale: :'pt-BR')
  end
end
