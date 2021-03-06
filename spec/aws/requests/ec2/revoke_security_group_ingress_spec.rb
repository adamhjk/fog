require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'EC2.revoke_security_group_ingress' do
  describe 'success' do

    before(:each) do
      AWS[:ec2].create_security_group('fog_security_group', 'a security group for testing fog')
      AWS[:ec2].authorize_security_group_ingress({
        'FromPort' => 80,
        'GroupName' => 'fog_security_group',
        'IpProtocol' => 'tcp',
        'ToPort' => 80
      })
    end

    after(:each) do
      AWS[:ec2].delete_security_group('fog_security_group')
    end

    it "should return proper attributes" do
      actual = AWS[:ec2].revoke_security_group_ingress({
        'FromPort' => 80,
        'GroupName' => 'fog_security_group',
        'IpProtocol' => 'tcp',
        'ToPort' => 80
      })
      actual.body['requestId'].should be_a(String)
      [false, true].should include(actual.body['return'])
    end

  end
end
