require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'Rackspace::Servers.get_flavors' do
  describe 'success' do

    it "should return proper attributes" do
      p servers.get_flavors
    end

  end
end