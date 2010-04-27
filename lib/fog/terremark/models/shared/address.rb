require 'fog/model'

module Fog
  module Terremark
    module Shared

      class Address < Fog::Model

        identity :id

        attribute :ip, 'name'

        def destroy
         requires :id
         connection.delete_public_ip(@id)
         true
        end

        private

        def href=(new_href)
          @id = new_href.split('/').last.to_i
        end

      end

    end
  end
end