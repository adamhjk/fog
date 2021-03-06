require 'rubygems'
require 'base64'
require 'cgi'
require 'digest/md5'
require 'excon'
require 'formatador'
require 'hmac-sha1'
require 'hmac-sha2'
require 'json'
require 'mime/types'
require 'net/ssh'
require 'nokogiri'
require 'time'

__DIR__ = File.dirname(__FILE__)

$LOAD_PATH.unshift __DIR__ unless
  $LOAD_PATH.include?(__DIR__) ||
  $LOAD_PATH.include?(File.expand_path(__DIR__))

require 'fog/collection'
require 'fog/connection'
require 'fog/deprecation'
require 'fog/model'
require 'fog/parser'
require 'fog/ssh'
require 'fog/aws'
require 'fog/rackspace'
require 'fog/slicehost'
require 'fog/terremark'

module Fog

  VERSION = '0.0.84'

  module Mock
    @delay = 1
    def self.delay
      @delay
    end

    def self.delay=(new_delay)
      raise ArgumentError, "delay must be non-negative" unless new_delay >= 0
      @delay = new_delay
    end
  end

  class MockNotImplemented < StandardError; end

  def self.mock!
    @mocking = true
  end

  def self.mocking?
    !!@mocking
  end

end
