require 'spec_helper'

describe SmartRspec::Macros do
  include SmartRspec

  subject(:user) do
    User.create({
      email:    Faker::Internet.email,
      name:     Faker::Name.name,
      username: Faker::Internet.user_name
    })
  end

  describe '#belongs_to' do
    context 'when it receives a single arg' do
      belongs_to :system
    end

    context 'when it receives multiple args' do
      belongs_to :system, :project
    end
  end

  describe '#has_attributes' do
    context 'when it receives a single arg' do
      has_attributes :email, :name, :username, type: :String
      has_attributes :is_admin, type: :Boolean
      has_attributes :score, type: :Integer, default: 0
      has_attributes :locale, type: :String, enum: [:en, :pt], default: 'en'
    end

    context 'when it receives multiple args' do
      has_attributes :name, :username, type: :String
    end
  end

  describe '#has_one' do
    context 'when it receives a single arg' do
      has_one :admin
    end

    context 'when it receives multiple args' do
      has_one :admin, :father, :mother
    end
  end

  describe '#has_many' do
    context 'when it receives a single arg' do
      has_one :articles
    end

    context 'when it receives multiple args' do
      has_one :articles, :rates
    end
  end

  describe '#fails_validation_of' do
    context 'when it receives a single arg' do
      new_user =
        User.new({
          email:    Faker::Internet.email,
          name:     Faker::Name.name,
          username: Faker::Internet.user_name
        })

      fails_validation_of :email, presence: true, email: true, uniqueness: { mock: new_user }
      fails_validation_of :name, length: { maximum: 80 }
      fails_validation_of :username, uniqueness: { mock: new_user }, exclusion: { in: %w(foo bar) }
      fails_validation_of :locale, inclusion: { in: %w(en pt) }
      fails_validation_of :father, format: { with: /foo/, mock: 'bar' }
    end

    context 'when it receives multiple args' do
      fails_validation_of :email, :name, presence: true
    end
  end
end
