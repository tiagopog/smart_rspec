module Factories
  class User
    attr_accessor :email, :system, :system_id, :project, :project_id,
                  :name, :username, :is_admin, :score, :admin, :father,
                  :mother, :articles, :rates
    attr_reader :errors

    def initialize(attrs = {})
      attrs.each { |key, value| self.send("#{key}=", value) }
      set_defaults
    end

    def set_defaults
      { errors: {}, is_admin: false, score: 0, locale: :en }.each do |key, value|
        eval "@#{key} ||= #{value.inspect}"
      end
    end

    def locale
      @locale.to_s unless @locale.nil?
    end

    def locale=(locale)
      if %i(en pt).include?(locale)
        @locale = locale
      else
        raise ArgumentError, 'Argument is invalid'
      end
    end

    def valid?
      (email.nil? || email.empty?) && (@errors = { email: "can't be blank" })
    end
  end
end

