require 'rspec/matchers'
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

RSpec::Matchers.define :be_image do |*types|
  match { |actual| actual =~ build_regex(:image, types) }
end

RSpec::Matchers.define :be_increasing do
end

RSpec::Matchers.define :be_decreasing do
end

RSpec::Matchers.define :have_error_on do |attr|
  match { |actual| actual.errors.keys.include?(attr) }
end

RSpec::Matchers.define :include_items do |*items|
  match { |actual| (items.flatten - [actual].flatten).empty? }
end

