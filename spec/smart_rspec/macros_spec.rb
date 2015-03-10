require 'spec_helper'

describe SmartRspec::Macros do
  include SmartRspec

  subject(:mock) do
    attrs = {
      email: Faker::Internet.email,
      name: Faker::Name.name,
      username: Faker::Internet.user_name,
      score: 10
    }
    User.new(attrs)
  end

  describe '#belongs_to' do
    context 'when it passes a single arg' do
      belongs_to :system
    end

    context 'when it passes multiple args' do
      belongs_to :system, :project
    end
  end

  describe '#has_attributes' do
    context 'when it passes a single arg' do
      has_attributes :email, type: :String
      has_attributes :is_admin, type: :Boolean
      has_attributes :score, type: :Integer
    end

    # has_attributes :name, :username, type: :String
    # has_attributes :credit, type: :Integer, default: 0
    # has_attributes :score, type: :Integer, default: 0
    # has_attributes :locale, type: :String, enum: %i(en pt), default: 'en'
  end
  describe '#has_one'
  describe '#has_many'
  describe '#fails_validation_of'
end

