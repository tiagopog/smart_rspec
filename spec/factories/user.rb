require 'smart_rspec/support/regexes'

module Factories
  class User
    include SmartRspec::Support::Regexes

    @@last_id = 0
    @@collection = []
    @@error_message = {
      blank: "can't be blank",
      too_big: "can't be greater than 80 chars",
      uniqueness: 'must be unique within the given scope'
    }

    attr_accessor :email, :system, :system_id, :project, :project_id,
                  :name, :username, :is_admin, :score, :admin, :father,
                  :mother, :articles, :rates

    attr_reader :id, :errors

    def initialize(attrs = {})
      attrs.each { |key, value| self.send("#{key}=", value) }
      set_defaults
      @@collection << self
    end

    class << self
      attr_reader :collection
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
      %w(email name).each { |e| send("check_#{e}") }
      @errors.nil?
    end

    private

    def check_email
      if !email || (email && email !~ build_regex(:email))
        @errors.merge!({ email: @@error_message[:blank] })
      end
    end

    def check_name
      if !name || (name && name.length > 80)
        @errors.merge!({ name: @@error_message[(name ? :too_big : :blank)] })
      end
    end

    def check_username
      other_user = @@collection.select { |e| e.name == name && e.username == username && e.id != id }.first
      if username && other_user
        @errors.merge!({ username: @@error_message[:uniqueness] })
      end
    end

    def set_defaults
      @@last_id = @id = @@last_id + 1
      { errors: {}, is_admin: false, score: 0, locale: :en }.each do |key, value|
        eval "@#{key} ||= #{value.inspect}"
      end
    end
  end
end

