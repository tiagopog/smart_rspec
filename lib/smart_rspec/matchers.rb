require 'rspec/matchers'

RSpec::Matchers.define :be_boolean do
  match { |actual| [true, false].include?(actual) }
end

RSpec::Matchers.define :be_email do
  match { |actual| actual =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end

RSpec::Matchers.define :be_url do
  url_regex = %r{\b(
    (((ht|f)tp[s]?://)|([a-z0-9]+\.))+
    (?<!@)
    ([a-z0-9\_\-]+)
    (\.[a-z]+)+
    ([\?/\:][a-z0-9_=%&@\?\./\-\:\#\(\)]+)?
    /?
  )}ix
  match { |actual| actual =~ url_regex }
end

RSpec::Matchers.define :be_image do |field|
end

RSpec::Matchers.define :have_error_on do |field|
end

RSpec::Matchers.define :be_increasing do
end

RSpec::Matchers.define :be_decreasing do
end

RSpec::Matchers.define :include_items do
end

