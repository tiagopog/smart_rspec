# SmartRspec

It's time to make your specs even more awesome! SmartRspec adds useful macros and matchers into the RSpec's suite so you can quickly define the specs for your Rails app.

## Installation

Compatible with Ruby 1.9+

Add this line to your application's Gemfile:

    gem 'smart_rspec'

Execute:

    $ bundle

Require the gem in top of your `spec/rails_helper.rb` (or equivalent):
``` ruby 
require 'smart_rspec'
```

Then include SmartRspec:

``` ruby 
RSpec.configure do |config|
  config.include SmartRspec
end
```

## Usage

### Macros

In order to use SmartRspec's macros in your spec file you just need to define a valid `subject`.

#### has_attributes

It builds specs for model attributes to test its type, enumerated values and defaults:
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

It builds specs to test model associations with `belongs_to`, `has_one` and `has_many`.
``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    belongs_to :business
    has_one :project
    has_many :tasks
end
```

#### fails_validation_of 

It builds specs and forces a model validation to fail in the given attribute. This means that you will only turn its specs into green when you specify the corresponding validation in the model.

``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    fails_validation_of :email, presence: true, email: true
    fails_validation_of :name, length: { maximum: 80 }, uniqueness: true
    fails_validation_of :username, length: { minimum: 10 }, exclusion: { in: %w(foo bar) }
    # Other validations...
end
```

The approach that `fails_validation_of` uses is similar to that used by ActiveRecord's `validates` method. The `fails_validation_of` implements specs for the following validations:

- `presence`
- `email`
- `length`
- `exclusion`
- `inclusion`
- `uniqueness`
- `format`

In two cases (scoped uniqueness and format validations) it requires a valid mock to be passed so SmartRspec can use it to force the validation to fail properly:

For scoped `:uniqueness`:
``` ruby
  other_user = FactoryGirl.build(:other_valid_user)
  fails_validation_of :username, uniqueness: { scope: :name, mock: other_user }
```

For `:format`:
``` ruby
fails_validation_of :foo, format: { with: /foo/, mock: 'bar' }
```

### Matchers

# TODO

- Create macros to help testing model scopes;
- Create macros to help testing Rails's controllers;
- Add more matchers.

## Contributing

1. Fork it;
2. Create your feature branch (`git checkout -b my-new-feature`);
3. Create your specs and make sure they are passing;
4. Document your feature in the README.md;
4. Commit your changes (`git commit -am 'Add some feature'`);
5. Push to the branch (`git push origin my-new-feature`);
6. Create new Pull Request.
