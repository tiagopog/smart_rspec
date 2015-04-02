require 'smart_rspec/support/regexes'

module Factories
  class User
    include SmartRspec::Support::Regexes

    @@last_id = 0
    @@collection = []
    @@error_message = {
      blank: "can't be blank",
      exclusion: "can't use a reserved value",
      format: "doesn't match the required pattern",
      inclusion: 'value not included',
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
      [:en, :pt].include?(locale) && @locale = locale
    end

    def persisted?; true end

    def valid?
      %w(email father locale name username).each { |e| send("check_#{e}") }
      @errors.nil?
    end

    private

    def check_email
      if !email || (email && email !~ build_regex(:email))
        @errors.merge!({ email: @@error_message[:blank] })
      end
    end

    def check_father
      if father && father !~ /foo/ 
        @errors.merge!({ father: @@error_message[:format] })
      end
    end

    def check_locale
      unless [:en, :pt].include?(locale)
        @errors.merge!({ locale: @@error_message[:inclusion] })
      end
    end

    def check_name
      if !name || (name && name.length > 80)
        @errors.merge!({ name: @@error_message[(name ? :too_big : :blank)] })
      end
    end

    def check_username
      other_user = @@collection.select { |e| e.name == name && e.username == username && e.id != id }.first
      if username && (other_user || %w(foo bar).include?(username))
        @errors.merge!({ username: @@error_message[other_user ? :uniqueness : :exclusion] })
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

