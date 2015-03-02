require 'smart_rspec/version'

module SmartRspec
  extend ActiveSupport::Concern

  included do
    include SmartRspec::Support::Expectations
  end

  module ClassMethods
    include SmartRspec::Macros
  end
end

