require 'json'
require 'recursive-open-struct'
require 'faraday'

class BillService

  def fetch_bill
    response = Faraday.get 'http://localhost:9292/bill.json'
    json = JSON.parse(response.body)
    RecursiveOpenStruct.new(json, recurse_over_arrays: true)
  end

end
