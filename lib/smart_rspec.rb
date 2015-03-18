%w(macros matchers support/expectations).each { |f| require "smart_rspec/#{f}" }

require 'active_support/concern'
require 'rspec/collection_matchers'
require 'rspec/matchers'

include SmartRspec::Matchers

module SmartRspec
  extend ActiveSupport::Concern

  included do
    include SmartRspec::Support::Expectations
  end

  module ClassMethods
    include SmartRspec::Macros
  end
end

