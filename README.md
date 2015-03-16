# SmartRspec

[![Build Status](https://travis-ci.org/tiagopog/smart_rspec.svg)](https://travis-ci.org/tiagopog/smart_rspec)
[![Code Climate](https://codeclimate.com/github/tiagopog/smart_rspec/badges/gpa.svg)](https://codeclimate.com/github/tiagopog/smart_rspec)
[![Dependency Status](https://gemnasium.com/tiagopog/smart_rspec.svg)](https://gemnasium.com/tiagopog/smart_rspec)
[![Gem Version](https://badge.fury.io/rb/smart_rspec.svg)](http://badge.fury.io/rb/smart_rspec)

It's time to make your specs even more awesome! SmartRspec adds useful macros and matchers into the RSpec's test suite, so you can quickly define specs for your Rails app and get focused on making things turn into green.

## Installation

Compatible with Ruby 1.9+

Add this line to your application's Gemfile:

    gem 'smart_rspec'

Execute:

    $ bundle

Require the gem at the top of your `spec/rails_helper.rb` (or equivalent):
``` ruby 
require 'smart_rspec'
```

Then include the SmartRspec module:

``` ruby 
RSpec.configure do |config|
  config.include SmartRspec
end
```

## Usage

* [Macros](#macros)
    * [has_attributes](#has_attributes)
    * [belongs_to, has_one, has_many](#belongs_to-has_one-has_many)
    * [fails_validation_of](#fails_validation_of)
* [Matchers](#matchers)
  * [be_ascending](#be_ascending)
  * [be_descending](#be_descending)
  * [be_boolean](#be_boolean)
  * [be_email](#be_email)
  * [be_url](#be_url)
  * [be_image_url](#be_image_url)
  * [have](#have)
  * [have_at_least](#have_at_least)
  * [have_at_most](#have_at_most)
  * [have_error_on](#have_error_on)
  * [include_items](#include_items)

### Macros

You will just need to define a valid `subject` to start using SmartRspec's macros in your spec file.

#### has_attributes

It builds specs for model attributes and test its type, enumerated values and defaults:
``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    has_attributes :email, type: :String
    has_attributes :is_admin, type: :Boolean
    has_attributes :score, type: :Integer, default: 0
    has_attributes :locale, type: :String, enum: %i(en pt), default: 'en'
end
```

#### belongs_to, has_one, has_many

It builds specs and test model associations like `belongs_to`, `has_one` and `has_many`.
``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    belongs_to :business
    has_one :project
    has_many :tasks
end
```

#### fails_validation_of 

It builds specs forcing model validations to fail, it means that you will only turn its specs into green when you specify the corresponding validation in the model.

``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    fails_validation_of :email, presence: true, email: true
    fails_validation_of :name, length: { maximum: 80 }, uniqueness: true
    fails_validation_of :username, length: { minimum: 10 }, exclusion: { in: %w(foo bar) }
    # Other validations...
end
```

The `fails_validation_of` implements specs for the following validations:

- `presence`
- `email`
- `length`
- `exclusion`
- `inclusion`
- `uniqueness`
- `format`

In two cases it will require a valid mock to be passed so SmartRspec can use it to force the validation to fail properly.

For uniqueness with scope:
``` ruby
  other_user = FactoryGirl.build(:other_valid_user)
  fails_validation_of :username, uniqueness: { scope: :name, mock: other_user }
```

For format:
``` ruby
fails_validation_of :foo, format: { with: /foo/, mock: 'bar' }
```

### Matchers

SmartRspec gathers a collection of custom useful matchers:

#### be_ascending

``` ruby
it { expect([1, 2, 3, 4]).to be_ascending }
it { expect([1, 4, 2, 3]).not_to be_ascending }
```

#### be_descending
``` ruby
it { expect([4, 3, 2, 1]).to be_descending }
it { expect([1, 2, 3, 4]).not_to be_descending }
```

#### be_boolean
``` ruby
it { expect(true).to be_boolean }
it { expect('true').not_to be_boolean }
```

#### be_email
``` ruby
it { expect('tiagopog@gmail.com').to be_email }
it { expect('tiagopog@gmail').not_to be_email }
```

#### be_url
``` ruby
it { expect('http://adtangerine.com').to be_url }
it { expect('adtangerine.com').not_to be_url }
```

#### be_image_url
``` ruby
it { expect('http://adtangerine.com/foobar.png').to be_image_url }
it { expect('http://adtangerine.com/foobar.jpg').not_to be_image_url(:gif) }
it { expect('http://adtangerine.com/foo/bar').not_to be_image_url }
```

#### have(x).items
``` ruby
it { expect([1]).to have(1).item }
it { expect(%w(foo bar)).to have(2).items }
it { expect(%w(foo bar)).not_to have(1).item }
```

#### have_at_least
``` ruby
it { expect(%w(foo bar foobar)).to have_at_least(3).items }
```

#### have_at_most
``` ruby
it { expect(%w(foo bar foobar)).to have_at_most(3).items }
```
#### have_error_on
``` ruby
subject(:user) { FactoryGirl.build(:user, email: nil) }

it 'has an invalid email' do
    user.valid?
    expect(user).to have_error_on(:email)
    expect(user).not_to have_error_on(:email)
end
```

#### include_items
``` ruby
it { expect(%w(foo bar foobar)).to include_items(%w(foo bar foobar)) }
```

# TODO

- Create macros for model scopes;
- Create macros for controllers;
- Add more matchers.

## Contributing

1. Fork it;
2. Create your feature branch (`git checkout -b my-new-feature`);
3. Create your specs and make sure they are passing;
4. Document your feature in the README.md;
4. Commit your changes (`git commit -am 'Add some feature'`);
5. Push to the branch (`git push origin my-new-feature`);
6. Create new Pull Request.

