require 'json'

module SmartRspec
  module Support
    module Controller
      module Response
        def json(response)
          @json ||= JSON.parse(response.body)
          self
        end

        def error
          @error ||= @json['errors'].first
        end

        def collection
          @collection ||= [@json['data']].flatten
        end

        def record_count
          @json['meta']['record_count']
        end

        def relationship_data
          @relationship_data ||= collection.flat_map do |record|
            record['relationships'].map do |_, relation|
              relation['data'].slice('type', 'id') if relation['data'].is_a?(Hash)
            end.compact
          end
        end

        def included_data
          return [] if @json['included'].nil?
          @included_data ||= @json['included'].flat_map do |record|
            record.slice('type', 'id')
          end
        end
      end
    end
  end
end
