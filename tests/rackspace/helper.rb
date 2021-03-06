module Rackspace

  def self.[](service)
    @@connections ||= Hash.new do |hash, key|
      credentials = Fog.credentials.reject do |k, v|
        ![:rackspace_api_key, :rackspace_username].include?(k)
      end
      hash[key] = case key
      when :files
        Fog::Rackspace::Files.new(credentials)
      when :servers
        Fog::Rackspace::Servers.new(credentials)
      end
    end
    @@connections[service]
  end

  module Files

    module Formats

    end

  end

  module Servers

    module Formats

      FLAVOR = {
        'disk'  => Integer,
        'id'    => Integer,
        'name'  => String,
        'ram'   => Integer
      }

      IMAGE = {
        'id'        => Integer,
        'name'      => String,
        'serverId'  => Integer,
        'status'    => String,
        'updated'   => String
      }

      SERVER = {
        'addresses' => {
          'private' => [String],
          'public'  => [String]
        },
        'flavorId'  => Integer,
        'hostId'    => String,
        'id'        => Integer,
        'imageId'   => Integer,
        'metadata'  => {},
        'name'      => String,
        'progress'  => Integer,
        'status'    => String
      }

      SUMMARY = {
        'id'    => Integer,
        'name'  => String
      }

    end

  end

end
