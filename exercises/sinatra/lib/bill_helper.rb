module BillHelper

  def format_currency(amount)
    format '£%.2f', amount
  end

  def format_date(date)
    Date.parse(date).strftime('%-d %b %Y')
  end

end
