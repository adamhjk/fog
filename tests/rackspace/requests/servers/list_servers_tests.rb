Shindo.tests('Rackspace::Servers#list_servers', 'rackspace') do
  tests('success') do

    before do
      @server_id = Rackspace[:servers].create_server(1, 3, 'foglistservers').body['server']['id']
      @data = Rackspace[:servers].list_servers.body['servers']
    end

    after do
      wait_for { Rackspace[:servers].get_server_details(@server_id).body['server']['status'] == 'ACTIVE' }
      Rackspace[:servers].delete_server(@server_id)
    end

    test('has proper output format') do
      validate_format(@data, Rackspace::Servers::Formats::SUMMARY)
    end

  end
end
