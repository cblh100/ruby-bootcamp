require 'json'

class BillService

  def fetch_bill
    file = File.read('bill.json')
    JSON.parse(file)
  end

end
