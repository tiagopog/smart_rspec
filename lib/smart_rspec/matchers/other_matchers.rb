module SmartRspec
  module Matchers
    module OtherMatchers
      extend RSpec::Matchers::DSL

      matcher :have_error_on do |attr|
        match { |actual| actual.errors.keys.include?(attr) }
      end

      matcher :include_items do |items|
        match { |actual| (items - actual).empty? }
      end
    end
  end
end

