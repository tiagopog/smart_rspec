module Factories
  class User
    attr_accessor :email
    attr_reader :errors

    def initialize(attrs)
      @email ||= attrs[:email]
      @errors = {}
    end

    def valid?
      (email.nil? || email.empty?) && (@errors = { email: "can't be blank" })
    end
  end
end

