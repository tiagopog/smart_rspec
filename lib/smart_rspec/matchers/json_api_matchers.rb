module SmartRspec
  module Matchers
    module JsonApiMatchers
      extend RSpec::Matchers::DSL
      include SmartRspec::Support::Controller::Response

      matcher :has_valid_id_and_type_members do |expected|
        match do |response|
          json(response).collection.all? do |record|
            record['id'].present? && record['type'] == expected
          end
        end
      end
    end
  end
end
