require 'smart_rspec/support/model/assertions'

module SmartRspec::Macros
  include SmartRspec::Support::Model::Assertions

  def belongs_to(*associations)
    assert_association :belongs_to, associations
  end

  def has_attributes(*attrs)
    options = attrs.last.is_a?(Hash) && attrs.last.key?(:type) ? attrs.pop : nil
    assert_has_attributes(attrs, options)
  end

  def has_one(*associations)
    assert_association :has_one, associations
  end

  def has_many(*associations)
    assert_association :has_many, associations
  end

  def fails_validation_of(*attrs, validations)
    attrs.each do |attr|
      context attr do
        validations.keys.each do |key|
          validation = validations[key]
          validation && send("validates_#{key}_of", attr, validation)
        end
      end
    end
  end
end
