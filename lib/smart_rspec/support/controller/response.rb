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
            record['relationships'].flat_map do |_, relation|
              [relation['data']].flatten.map { |data| data.slice('type', 'id') }
            end.compact
          end
        end

        def included_data
          return [] if @json['included'].nil?
          @included_data ||= @json['included'].flat_map do |record|
            record.slice('type', 'id')
          end
        end

        def check_keys_in(member, keys)
          collection.all? do |record|
            record[member].keys.sort == keys.sort
          end
        end
      end
    end
  end
end
