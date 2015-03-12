require 'smart_rspec/support/regexes'

module Factories
  class User
    include SmartRspec::Support::Regexes

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
      if !email || (email && email !~ build_regex(:email))
        @errors.merge!({ email: @@error_message[:blank] })
      elsif !name || (name && name.length > 80)
        @errors.merge!({ name: @@error_message[(name ? :too_big : :blank)] })
      end
      @errors.nil?
    end

    private

    @@error_message = {
      blank: "can't be blank",
      too_big: "can't be greater than 80 chars"
    }
  end
end

