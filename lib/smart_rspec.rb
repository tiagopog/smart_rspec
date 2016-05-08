require 'active_support/concern'
require 'rspec/collection_matchers'
require 'rspec/matchers'

%w(macros matchers support/model/expectations).each { |f| require "smart_rspec/#{f}" }

include SmartRspec::Matchers

module SmartRspec
  extend ActiveSupport::Concern

  included do
    include SmartRspec::Support::Model::Expectations
  end

  module ClassMethods
    include SmartRspec::Macros
  end
end

