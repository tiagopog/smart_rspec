require 'rspec/matchers'
require 'rspec/collection_matchers'
require 'smart_rspec/support/regexes'

module SmartRspec
  module Matchers
    extend RSpec::Matchers::DSL
    include SmartRspec::Support::Regexes

    matcher :be_boolean do
      match { |actual| [true, false].include?(actual) }
    end

    matcher :be_email do
      match { |actual| actual =~ build_regex(:email) }
    end

    matcher :be_url do
      match { |actual| actual =~ build_regex(:uri) }
    end

    matcher :be_image_url do |*types|
      match { |actual| actual =~ build_regex(:image, types) }
    end

    matcher :have_error_on do |attr|
      match { |actual| actual.errors.keys.include?(attr) }
    end

    matcher :include_items do |*items|
      match { |actual| (items.flatten - [actual].flatten).empty? }
    end

    matcher :be_ascending do
      match { |actual| actual == actual.sort  }
    end

    matcher :be_descending do
      match { |actual| actual.each_cons(2).all? { |i, j| i >= j  } }
    end
  end
end

