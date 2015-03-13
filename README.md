# SmartRspec

It's time to make your specs even more awesome! SmartRspec adds useful macros and matchers into the RSpec's suite so you can quickly define the specs for your Rails app.

## Installation

Compatible with Ruby 1.9+

Add this line to your application's Gemfile:

    gem 'smart_rspec'

Execute:

    $ bundle

Require the gem in your "spec/rails_spec.rb":
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

In order to use SmartRspec's macros in your spec file you just need to define a valid "subject" of your cass/model.

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

It builds specs to test model associations for "belongs_to", "has_one" and "has_many".
``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    belongs_to :system
    has_one :project
    has_many :tasks
end
```

#### fails_validation_of 

It builds specs and forces a model validation to fail in the given attribute.

``` ruby
RSpec.describe User, type: :model do
    subject { FactoryGirl.build(:user) }
    
    fails_validation_of :email, presence: true, email: true
    fails_validation_of :name, length: { maximum: 80 }
end
```

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
