require 'spec_helper'

describe SmartRspec::Matchers do
  describe BeMatchers do
    describe '#be_ascending' do
      context 'positive assertion' do
        it { expect([1, 2, 3, 4]).to be_ascending }
      end

      context 'negative assertion' do
        it { expect([1, 4, 2, 3]).not_to be_ascending }
      end
    end

    describe '#be_boolean' do
      context 'positive assertion' do
        it { expect(true).to be_boolean }
        it { expect(false).to be_boolean }
      end

      context 'negative assertion' do
        it { expect('true').not_to be_boolean }
        it { expect(1).not_to be_boolean }
        it { expect(%w(foo bar)).not_to be_boolean }
      end
    end

    describe '#be_descending' do
      context 'positive assertion' do
        it { expect([4, 3, 2, 1]).to be_descending }
      end

      context 'negative assertion' do
        it { expect([1, 2, 3, 4]).not_to be_descending }
      end
    end

    describe '#be_email' do
      context 'positive assertion' do
        it { expect(Faker::Internet.email).to be_email }
        it { expect('tiagopog@gmail.com').to be_email }
        it { expect('foo@bar.com.br').to be_email }
      end

      context 'negative assertion' do
        it { expect('foo@bar').not_to be_email }
        it { expect('foo@').not_to be_email }
        it { expect('@bar').not_to be_email }
        it { expect('@bar.com').not_to be_email }
        it { expect('foo bar@bar.com').not_to be_email }
      end
    end

    describe '#be_url' do
      context 'positive assertion' do
        it { expect(Faker::Internet.url).to be_url }
        it { expect('http://adtangerine.com').to be_url }
        it { expect('http://www.facebook.com').to be_url }
        it { expect('www.twitflink.com').to be_url }
        it { expect('google.com.br').to be_url }
      end

      context 'negative assertion' do
        it { expect('foobar.bar').not_to be_url }
        it { expect('foobar').not_to be_url }
        it { expect('foo bar.com.br').not_to be_url }
      end
    end

    describe '#be_image_url' do
      context 'positive assertion' do
        it { expect(Faker::Company.logo).to be_image_url }
        it { expect('http://foobar.com/foo.jpg').to be_image_url }
        it { expect('http://foobar.com/foo.jpg').to be_image_url(:jpg) }
        it { expect('http://foobar.com/foo.gif').to be_image_url(:gif) }
        it { expect('http://foobar.com/foo.png').to be_image_url(:png) }
        it { expect('http://foobar.com/foo.png').to be_image_url([:jpg, :png]) }
        it { expect('http://foobar.com/foo/bar?image=foo.jpg').to be_image_url }
      end

      context 'negative assertion' do
        it { expect('http://foobar.com').not_to be_image_url }
        it { expect('http://foobar.com/foo.jpg').not_to be_image_url(:gif) }
        it { expect('http://foobar.com/foo.gif').not_to be_image_url(:png) }
        it { expect('http://foobar.com/foo.png').not_to be_image_url(:jpg) }
        it { expect('http://foobar.com/foo.gif').not_to be_image_url([:jpg, :png]) }
      end
    end

    describe '#be_a_list_of' do
      context 'positive assertion' do
        subject { Array.new(3, User.new) }
        it { is_expected.to be_a_list_of(User) }
      end

      context 'negative assertion' do
        subject { Array.new(3, User.new) << nil }
        it { is_expected.to_not be_a_list_of(User) }
      end
    end
  end

  describe JsonApiMatchers do
    subject(:response) { Fixtures::Response.new }

    describe '#have_primary_data' do
      context 'positive assertion' do
        it do
          expect(response).to have_primary_data('users')
        end
      end

      context 'negative assertion' do
        it do
          expect(response).not_to have_primary_data('foobar')
        end
      end
    end

    describe '#have_data_attributes' do
      let(:fields) { %w(first_name last_name full_name birthday) }

      context 'positive assertion' do
        it do
          expect(response).to have_data_attributes(fields)
        end
      end

      context 'negative assertion' do
        it do
          expect(response).not_to have_data_attributes(fields + %w(foobar))
        end
      end
    end

    describe '#have_relationships' do
      let(:relationships) { %w(posts) }

      context 'positive assertion' do
        it do
          expect(response).to have_relationships(relationships)
        end
      end

      context 'negative assertion' do
        it do
          expect(response).not_to have_relationships(relationships + %w(foobar))
        end
      end
    end

    describe '#have_included_relationships' do
      let(:relationships) { %w(posts) }

      context 'positive assertion' do
        it do
          expect(response).to have_included_relationships
        end
      end
    end

    describe '#have_meta_record_count' do
      context 'positive assertion' do
        it do
          expect(response).to have_meta_record_count(2)
        end
      end

      context 'negative assertion' do
        it do
          expect(response).not_to have_meta_record_count(3)
        end
      end
    end
  end

  describe OtherMatchers do
    describe '#have_error_on' do
      subject { User.new(email: nil, name: Faker::Name.name) }

      context 'positive assertion' do
        it do
          subject.valid?
          is_expected.to have_error_on(:email)
        end
      end

      context 'negative assertion' do
        it do
          subject.valid?
          is_expected.not_to have_error_on(:name)
        end
      end
    end

    describe '#include_items' do
      context 'positive assertion' do
        it { expect(%w(foo bar foobar)).to include_items(%w(foo bar foobar)) }
        it { expect(%w(lorem ipsum)).to include_items('lorem', 'ipsum') }
        it { expect([1, 'foo', ['bar']]).to include_items([1, 'foo', ['bar']]) }
      end

      context 'negative assertion' do
        it { expect(%w(foo bar foobar)).not_to include_items(%w(lorem)) }
      end
    end
  end

  describe ::RSpec::CollectionMatchers do
    describe '#have' do
      context 'positive assertion' do
        it { expect([1]).to have(1).item }
        it { expect(%w(foo bar)).to have(2).items }
      end

      context 'negative assertion' do
        it { expect([1]).not_to have(2).items }
        it { expect(%w(foo bar)).not_to have(1).item }
      end
    end

    describe '#have_at_least' do
      context 'positive assertion' do
        it { expect(%w(foo bar foobar)).to have_at_least(3).items }
      end
    end

    describe '#have_at_most' do
      context 'positive assertion' do
        it { expect(%w(foo bar foobar)).to have_at_most(3).items }
      end
    end
  end
end
