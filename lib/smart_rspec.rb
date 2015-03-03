require 'active_support/concern'
require 'smart_rspec/macros'
require 'smart_rspec/support/expectations'

module SmartRspec
  extend ActiveSupport::Concern

  included do
    include SmartRspec::Support::Expectations
  end

  module ClassMethods
    include SmartRspec::Macros
  end
end

