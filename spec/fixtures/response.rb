module Fixtures
  class Response
    def initialize
      @file = File.read('spec/fixtures/users.json')
    end

    def body
      @file
    end
  end
end
