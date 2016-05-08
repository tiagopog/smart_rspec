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
      end
    end
  end
end
