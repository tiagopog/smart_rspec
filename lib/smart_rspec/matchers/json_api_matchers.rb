module SmartRspec
  module Matchers
    module JsonApiMatchers
      extend RSpec::Matchers::DSL
      include SmartRspec::Support::Controller::Response

      matcher :have_primary_data do |expected|
        match do |response|
          json(response).collection.all? do |record|
            record['id'].present? && record['type'] == expected
          end
        end
      end

      matcher :have_fetchable_fields do |fields|
        match do |response|
          json(response).collection.all? do |record|
            record['attributes'].keys.sort == fields.sort
          end
        end
      end

      matcher :have_relationships do |relationships|
        match do |response|
          json(response).collection.all? do |record|
            record['relationships'].keys.sort == relationships.sort
          end
        end
      end

      matcher :have_included_relationships do
        match do |response|
          json(response)
          return false if included_data.empty? || relationship_data.empty?
          included_data.size == relationship_data.size &&
            (included_data - relationship_data).empty?
        end
      end

      matcher :have_meta_record_count do |count|
        match do |response|
          json(response).record_count == count
        end
      end
    end
  end
end
