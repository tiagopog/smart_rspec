module SmartRspec
  module Support
    module Expectations
      def assert_validation(attr, value = nil, mock = nil)
        mock ||= subject
        mock.send("#{attr}=", value)

        expect(mock).not_to be_valid
        expect(mock).to have_error_on(attr)
      end

      def check_attr_options(attr, options)
        options.each do |k, v|
          if k == :default
            expect(subject.send(attr)).to eq(v)
          elsif k == :enum
            expect(v).to include(subject.send(attr).to_sym)
          elsif k == :type
            assert_type =
              if v != :Boolean
                be_kind_of(Kernel.const_get(v))
              else
                be_boolean
              end
            expect(subject.send(attr)).to assert_type
          end
        end
      end
    end
  end
end

