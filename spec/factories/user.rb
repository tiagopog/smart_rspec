module Factories
  class User
    attr_accessor :email, :system, :system_id, :project, :project_id,
                  :name, :username, :is_admin, :score
    attr_reader :errors

    def initialize(attrs = {})
      attrs.keys.each do |key|
        self.send("#{key}=", attrs[key])
      end

      @errors ||= {}
      @is_admin ||= false
    end

    def valid?
      (email.nil? || email.empty?) && (@errors = { email: "can't be blank" })
    end
  end
end

