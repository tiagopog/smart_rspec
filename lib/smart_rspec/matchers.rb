require 'rspec/matchers'
require 'rspec/collection_matchers'
require 'smart_rspec/support/regexes'

include SmartRspec::Support::Regexes

RSpec::Matchers.define :be_boolean do
  match { |actual| [true, false].include?(actual) }
end

RSpec::Matchers.define :be_email do
  match { |actual| actual =~ build_regex(:email) }
end

RSpec::Matchers.define :be_url do
  match { |actual| actual =~ build_regex(:uri) }
end

RSpec::Matchers.define :be_image_url do |*types|
  match { |actual| actual =~ build_regex(:image, types) }
end

RSpec::Matchers.define :have_error_on do |attr|
  match { |actual| actual.errors.keys.include?(attr) }
end

RSpec::Matchers.define :include_items do |*items|
  match { |actual| (items.flatten - [actual].flatten).empty? }
end

RSpec::Matchers.define :be_ascending do
  match { |actual| actual == actual.sort  }
end

RSpec::Matchers.define :be_descending do
  match { |actual| actual.each_cons(2).all? { |i, j| i >= j  } }
end

