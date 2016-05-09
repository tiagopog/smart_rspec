require 'smart_rspec/support/regexes'

module Fixtures
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
                  :mother, :articles, :rates, :errors

    attr_reader :id

    attr_writer :locale

    def initialize(attrs = {})
      attrs.each { |key, value| self.send("#{key}=", value) }
      set_defaults
    end

    class << self
      attr_reader :collection

      def create(attrs)
        user = User.new(attrs)
        @@collection << user && user
      end

      def find_by(key, value)
        @@collection.find { |e| e.send(key) == value }
      end
    end

    def save
      @@collection << self
    end

    def locale
      @locale.to_s unless @locale.nil?
    end

    def persisted?
      User.find_by(:id, id)
    end

    def valid?
      %w(email father locale name username).each { |e| send("check_#{e}") }
      @errors.nil?
    end

    private

    def check_email
      if !email || (email && email !~ build_regex(:email))
        @errors.merge!({ email: @@error_message[:blank] })
      elsif User.find_by(:email, email)
        @errors.merge!({ email: @@error_message[:uniqueness] })
      end
    end

    def check_father
      if father && father !~ /foo/ 
        @errors.merge!({ father: @@error_message[:format] })
      end
    end

    def check_locale
      unless %w(en pt).include?(locale)
        @errors.merge!({ locale: @@error_message[:inclusion] })
      end
    end

    def check_name
      if !name || (name && name.length > 80)
        @errors.merge!({ name: @@error_message[(name ? :too_big : :blank)] })
      end
    end

    def check_username
      if username.to_s.empty?
        @errors.merge!({ username: @@error_message[:blank] })
      elsif %w(foo bar).include?(username)
        @errors.merge!({ username: @@error_message[:exclusion] })
      elsif User.find_by(:username, username)
        @errors.merge!({ username: @@error_message[:uniqueness] })
      end
    end

    def set_defaults
      @@last_id = @id = @@last_id + 1
      attrs = { errors: {}, is_admin: false, score: 0, locale: :en }
      attrs.each { |key, value| send("#{key}=", value) }
    end
  end
end
