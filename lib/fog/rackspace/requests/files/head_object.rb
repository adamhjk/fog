module Fog
  module Rackspace
    module Files
      class Real

        # Get headers for object
        #
        # ==== Parameters
        # * container<~String> - Name of container to look in
        # * object<~String> - Name of object to look for
        #
        def head_object(container, object)
          response = storage_request({
            :expects  => 200,
            :method   => 'GET',
            :path     => "#{CGI.escape(container)}/#{CGI.escape(object)}"
          }, false)
          response
        end

      end

      class Mock

        def head_object(container, object)
          raise MockNotImplemented.new("Contributions welcome!")
        end

      end
    end
  end
end
