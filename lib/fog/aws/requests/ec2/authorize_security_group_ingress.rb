module Fog
  module AWS
    module EC2
      class Real

        # Add permissions to a security group
        #
        # ==== Parameters
        # * options<~Hash>:
        #   * 'GroupName'<~String> - Name of group
        #   * 'SourceSecurityGroupName'<~String> - Name of security group to authorize
        #   * 'SourceSecurityGroupOwnerId'<~String> - Name of owner to authorize
        #   or
        #   * 'CidrIp' - CIDR range
        #   * 'FromPort' - Start of port range (or -1 for ICMP wildcard)
        #   * 'GroupName' - Name of group to modify
        #   * 'IpProtocol' - Ip protocol, must be in ['tcp', 'udp', 'icmp']
        #   * 'ToPort' - End of port range (or -1 for ICMP wildcard)
        #
        # === Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def authorize_security_group_ingress(options = {})
          request({
            'Action'  => 'AuthorizeSecurityGroupIngress',
            :parser   => Fog::Parsers::AWS::EC2::Basic.new
          }.merge!(options))
        end

      end

      class Mock

        def authorize_security_group_ingress(options = {})
          response = Excon::Response.new
          group = @data[:security_groups][options['GroupName']]
          group['ipPermissions'] ||= []

          if options['GroupName'] && options['SourceSecurityGroupName'] && options['SourceSecurityGroupOwnerId']
            ['icmp', 'tcp', 'udp'].each do |protocol|
              group['ipPermissions'] << {
                'groups'      => [{'groupName' => options['GroupName'], 'userId' => @owner_id}],
                'fromPort'    => 1,
                'ipRanges'    => [],
                'ipProtocol'  => protocol,
                'toPort'      => 65535
              }
            end
          else
            group['ipPermissions'] << {
              'groups'      => [],
              'fromPort'    => options['FromPort'],
              'ipRanges'    => [{ 'cidrIp' => options['CidrIp'] }],
              'ipProtocol'  => options['IpProtocol'],
              'toPort'      => options['ToPort']
            }
          end
          response.status = 200
          response.body = {
            'requestId' => Fog::AWS::Mock.request_id,
            'return'    => true
          }
          response
        end

      end
    end
  end
end
