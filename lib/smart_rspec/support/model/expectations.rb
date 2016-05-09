module SmartRspec
  module Support
    module Model
      module Expectations
        def be_valid_expectation(attr, value = nil, mock = nil)
          mock ||= subject
          mock.send("#{attr}=", value)

          expect(mock).not_to be_valid
          expect(mock).to have_error_on(attr)
        end

        def default_expectation(attr, value)
          expect(subject.send(attr)).to eq(value)
        end

        def enum_expectation(attr, value)
          expect(value).to include(subject.send(attr).to_sym)
        end

        def type_expectation(attr, value)
          assert_type = value != :Boolean ? be_kind_of(Kernel.const_get(value)) : be_boolean
          expect(subject.send(attr)).to assert_type
        end

        def has_attributes_expectation(attr, options) options.each do |key, value|
            send("#{key}_expectation", attr, value)
          end
        end

        def association_expectation(type, model)
          if type == :has_many
            expect(subject).to respond_to("#{model.to_s.singularize}_ids")
          elsif type == :belongs_to
            %W(#{model}= #{model}_id #{model}_id=).each do |method|
              expect(subject).to respond_to(method)
            end
          end
        end
      end
    end
  end
end
