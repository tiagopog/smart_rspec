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
      (!name.nil? && name.length > 80) && (@errors.merge!({ name: "can't be greater than 80 chars" }))
      (email.nil? || email.empty?) && (@errors.merge!({ email: "can't be blank" }))
      (!email.nil? && !(email =~ build_regex(:email))) && (@errors.merge!({ email: 'invalid format for email' })) && return false)
    end
  end
end

