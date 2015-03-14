module SmartRspec
  module Support
    module Assertions
      private_class_method

      def validates_email_of(attr, validation)
        it 'has an invalid format' do
          %w(foobar foobar@ @foobar foo@bar).each do |e|
            assert_validation(attr, e)
          end
        end
      end

      def validates_exclusion_of(attr, validation)
        it 'has a reserved value' do
          assert_validation(attr, validation[:in].sample)
        end
      end

      def validates_format_of(attr, validation)
        it 'does not match the required format' do
          mock, with =
            validation.values_at(:mock).first,
            validation.values_at(:with).first

          if mock && with && with !~ mock
            assert_validation(attr, mock)
          else
            raise ArgumentError, ':with and :mock are required when using the :format validation'
          end
        end
      end

      def validates_inclusion_of(attr, validation)
        it 'is out of the scope of possible values' do
          begin
            value = SecureRandom.hex
          end while validation[:in].include?(value)
          assert_validation(attr, value)
        end
      end

      def validates_length_of(attr, validation)
        validation.each do |key, value|
          next unless %i(in is maximum minimum within).include?(key)
          txt, n = build_length_validation(key, value)
          it txt do
            assert_validation(attr, 'x' * n)
          end
        end
      end

      def validates_presence_of(attr, validation)
        it 'is blank' do
          assert_validation(attr, nil)
        end
      end

      def validates_uniqueness_of(attr, validation)
        scoped = scoped_validation?(validation)
        scope = scoped ? validation[:scope] : nil

        it "is already in use#{" (scope: #{scope})" if scoped}" do
          mock = (validation[:mock] rescue nil) || subject.dup
          scoped && mock.send("#{scope}=", subject.send(scope))

          assert_validation(attr, subject.send(attr), mock)
        end
      end

      def assert_has_attributes(attrs, options)
        type_str = build_type_str(options)

        attrs.each do |attr|
          it %Q(has an attribute named "#{attr}"#{type_str}) do
            expect(subject).to respond_to(attr)
            check_attr_options(attr, options)
          end
        end
      end

      def assert_association(assoc_type, associations)
        associations.each do |association|
          it "#{assoc_type.to_s.gsub('_', ' ')} #{association}" do
            expect(subject).to respond_to(association)
            case assoc_type
            when :belongs_to
              %W(#{association}= #{association}_id #{association}_id=).each do |method|
                expect(subject).to respond_to(method)
              end
            when :has_many
              expect(subject).to respond_to("#{association.to_s.singularize}_ids")
            end
          end
        end
      end

      def build_length_validation(key, value)
        case key
        when :in, :within then ['is out of the length range', value.max + 1]
        when :is, :minimum then ["is #{key == :is ? 'invalid' : 'too short'}", value - 1]
        when :maximum then ['is too long', value + 1]
        end
      end

      def build_type_str(options)
        if !options.nil? && options[:type]
          " (%s%s%s)" % [
            ('Enumerated ' if options[:enum]),
            options[:type],
            (", default: #{options[:default]}" if options[:default])
          ]
        end
      end

      def scoped_validation?(validation)
        validation.is_a?(Hash) && (%i(scope mock) - validation.keys).empty?
      end
    end
  end
end

