require 'webmock'

WebMock.allow_net_connect!
WebMock.stub_request(:get, %r{.*/bill\.json$}).to_return(body: File.read('bill.json'))
