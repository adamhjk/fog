Shindo.tests('Rackspace::Servers#list_private_addresses', 'rackspace') do
  tests('success') do

    before do
      @server_id = Rackspace[:servers].create_server(1, 3, 'foglistprivateaddresses').body['server']['id']
      @data = Rackspace[:servers].list_private_addresses(@server_id).body
    end

    after do
      wait_for { Rackspace[:servers].get_server_details(@server_id).body['server']['status'] == 'ACTIVE' }
      Rackspace[:servers].delete_server(@server_id)
    end

    test('has proper output format') do
      validate_format(@data, [String])
    end

  end
  tests('failure') do

    test('raises NotFound error if server does not exist') do
      begin
        Rackspace[:servers].list_private_addresses(0)
        false
      rescue Excon::Errors::NotFound
        true
      end
    end

  end

end
