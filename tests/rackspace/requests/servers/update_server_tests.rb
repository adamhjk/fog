Shindo.tests('Rackspace::Servers#update_server', 'rackspace') do
  tests('success') do

    before do
      @server_id = Rackspace[:servers].create_server(1, 3, 'fogupdateserver').body['server']['id']
      wait_for { Rackspace[:servers].get_server_details(@server_id).body['server']['status'] == 'ACTIVE' }
      @data = Rackspace[:servers].update_server(@server_id, :name => 'fogupdatedserver', :adminPass => 'fogupdatedserver')
    end

    after do
      Rackspace[:servers].delete_server(@server_id)
    end

    test('has proper output format') do
      validate_format(@data, {'name' => String, 'adminPass' => String})
    end

  end
  tests('failure') do

    test('raises NotFound error if server does not exist') do
      begin
        Rackspace[:servers].update_server(0, :name => 'fogupdatedserver', :adminPass => 'fogupdatedserver')
        false
      rescue Excon::Errors::NotFound
        true
      end
    end

  end

end
