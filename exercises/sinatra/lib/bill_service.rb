require 'json'
require 'recursive-open-struct'

class BillService

  def fetch_bill
    file = File.read('bill.json')
    json = JSON.parse(file)
    RecursiveOpenStruct.new(json, recurse_over_arrays: true)
  end

end
