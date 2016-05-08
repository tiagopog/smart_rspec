module SmartRspec
  module Matchers
    module BeMatchers
      extend RSpec::Matchers::DSL

      matcher :be_ascending do
        match { |actual| actual == actual.sort  }
      end

      matcher :be_a_list_of do |klass|
        match do |collection|
          collection.all? { |e| e.is_a?(klass) }
        end
      end

      matcher :be_boolean do
        match { |actual| [true, false].include?(actual) }
      end

      matcher :be_descending do
        match do |actual|
          actual.each_cons(2).all? { |i, j| i >= j  }
        end
      end

      matcher :be_email do
        match { |actual| actual =~ build_regex(:email) }
      end

      matcher :be_image_url do |*types|
        match { |actual| actual =~ build_regex(:image, types) }
      end

      matcher :be_url do
        match { |actual| actual =~ build_regex(:uri) }
      end
    end
  end
end

