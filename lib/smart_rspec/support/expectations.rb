module SmartRspec
  module Support
    module Expectations
      def assert_attr_type(attr, type, other)
        assert_type = type == :Boolean ? be_boolean : be_kind_of(Kernel.const_get(type))
        expect(subject.send(attr)).to assert_type
      end

      def assert_validation(attr, value = nil, mock = nil)
        mock ||= subject
        mock.send("#{attr}=", value)

        expect(mock).not_to be_valid
        expect(mock).to have_error_on(attr)
      end
    end
  end
end

