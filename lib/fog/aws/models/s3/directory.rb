require 'fog/model'
require 'fog/aws/models/s3/files'

module Fog
  module AWS
    module S3

      class Directory < Fog::Model

        identity  :name,          'Name'

        attribute :creation_date, 'CreationDate'

        def destroy
          requires :name
          connection.delete_bucket(@name)
          true
        rescue Excon::Errors::NotFound
          false
        end

        def location
          requires :name
          data = connection.get_bucket_location(@name)
          data.body['LocationConstraint']
        end

        def location=(new_location)
          @location = new_location
        end

        def files
          @files ||= begin
            Fog::AWS::S3::Files.new(
              :directory    => self,
              :connection   => connection
            )
          end
        end

        def payer
          requires :name
          data = connection.get_request_payment(@name)
          data.body['Payer']
        end

        def payer=(new_payer)
          requires :name
          connection.put_request_payment(@name, new_payer)
          @payer = new_payer
        end

        def save
          requires :name
          options = {}
          if @location
            options['LocationConstraint'] = @location
          end
          connection.put_bucket(@name, options)
          true
        end

      end

    end
  end
end
