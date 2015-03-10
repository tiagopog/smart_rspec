require 'spec_helper'

describe 'SmartRspec Matchers' do
  describe '#be_ascending' do
    context 'when valid' do
      it { expect([1, 2, 3, 4]).to be_ascending }
    end

    context 'when invalid' do
      it { expect([1, 4, 2, 3]).not_to be_ascending }
    end
  end

  describe '#be_boolean' do
    context 'when valid' do
      it { expect(true).to be_boolean }
      it { expect(false).to be_boolean }
    end

    context 'when invalid' do
      it { expect('true').not_to be_boolean }
      it { expect(1).not_to be_boolean }
      it { expect(%w(foo bar)).not_to be_boolean }
    end
  end

  describe '#be_descending' do
    context 'when valid' do
      it { expect([4, 3, 2, 1]).to be_descending }
    end

    context 'when invalid' do
      it { expect([1, 2, 3, 4]).not_to be_descending }
    end
  end

  describe '#be_email' do
    context 'when valid' do
      it { expect('tiagopog@gmail.com').to be_email }
      it { expect('foo@bar.com.br').to be_email }
    end

    context 'when invalid' do
      it { expect('foo@bar').not_to be_email }
      it { expect('foo@').not_to be_email }
      it { expect('@bar').not_to be_email }
      it { expect('@bar.com').not_to be_email }
      it { expect('foo bar@bar.com').not_to be_email }
    end
  end

  describe '#be_url' do
    context 'when valid' do
      it { expect('http://adtangerine.com').to be_url }
      it { expect('http://www.facebook.com').to be_url }
      it { expect('www.twitflink.com').to be_url }
      it { expect('google.com.br').to be_url }
    end

    context 'when invalid' do
      it { expect('foobar.bar').not_to be_url }
      it { expect('foobar').not_to be_url }
      it { expect('foo bar.com.br').not_to be_url }
    end
  end

  describe '#be_image_url' do
    context 'when valid' do
      it { expect('http://foobar.com/foo.jpg').to be_image_url }
      it { expect('http://foobar.com/foo.jpg').to be_image_url(:jpg) }
      it { expect('http://foobar.com/foo.gif').to be_image_url(:gif) }
      it { expect('http://foobar.com/foo.png').to be_image_url(:png) }
      it { expect('http://foobar.com/foo.png').to be_image_url(%i(jpg png)) }
      it { expect('http://foobar.com/foo/bar?image=foo.jpg').to be_image_url }
    end

    context 'when invalid' do
      it { expect('http://foobar.com').not_to be_image_url }
      it { expect('http://foobar.com/foo.jpg').not_to be_image_url(:gif) }
      it { expect('http://foobar.com/foo.gif').not_to be_image_url(:png) }
      it { expect('http://foobar.com/foo.png').not_to be_image_url(:jpg) }
      it { expect('http://foobar.com/foo.gif').not_to be_image_url(%i(jpg png)) }
    end
  end

  describe '#have' do
    context 'when valid' do
      it { expect([1]).to have(1).item }
      it { expect(%w(foo bar)).to have(2).items }
    end

    context 'when invalid' do
      it { expect([1]).not_to have(2).items }
      it { expect(%w(foo bar)).not_to have(1).item }
    end
  end

  describe '#have_at_least' do
    context 'when valid' do
      it { expect(%w(foo bar foobar)).to have_at_least(3).items }
    end
  end

  describe '#have_at_most' do
    context 'when valid' do
      it { expect(%w(foo bar foobar)).to have_at_most(3).items }
    end
  end

  describe '#have_error_on' do
    subject(:mock) { User.new(email: '') }

    context 'when valid' do
      it do
        mock.valid?
        expect(mock).to have_error_on(:email)
      end
    end

    context 'when invalid' do
      it do
        mock.email = 'tiagopog@gmail.com'
        mock.valid?

        expect(mock).not_to have_error_on(:email)
      end
    end
  end

  describe '#include_items' do
    context 'when valid' do
      it { expect(%w(foo bar foobar)).to include_items(%w(foo bar foobar)) }
      it { expect([1, 'foo', ['bar']]).to include_items([1, 'foo', ['bar']]) }
    end

    context 'when invalid' do
      it { expect(%w(foo bar foobar)).not_to include_items(%w(lorem)) }
    end
  end
end

