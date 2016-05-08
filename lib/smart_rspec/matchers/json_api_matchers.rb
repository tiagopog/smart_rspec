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

      matcher :has_fetchable_fields do |fields|
        match do |response|
          json(response).collection.all? do |record|
            record['attributes'].keys.sort == fields.sort
          end
        end
      end

      matcher :has_relationship_members do |relationships|
        match do |response|
          json(response).collection.all? do |record|
            record['relationships'].keys.sort == relationships.sort
          end
        end
      end

      matcher :has_meta_record_count do |count|
        match do |response|
          json(response).record_count == count
        end
      end

      matcher :has_included_relationships do
        match do |response|
          json(response)
          return false if included_data.empty? || relationship_data.empty?
          included_data.size == relationship_data.size &&
            (included_data - relationship_data).empty?
        end
      end
    end
  end
end