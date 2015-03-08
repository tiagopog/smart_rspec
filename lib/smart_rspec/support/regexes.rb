module SmartRspec
  module Support
    module Regexes
      def build_regex(type, *args)
        type = type.to_sym unless type.is_a? Symbol
        case type
        when :email
          /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        when :image
          build_img_regex(args.flatten)
        else
          build_uri_regex[type]
        end
      end

      private_class_method

      def build_img_regex(exts = [])
        exts = [exts].flatten unless exts.is_a?(Array)
        if exts.nil? || exts.empty?
          exts = %w(jpg jpeg png gif)
        elsif exts.include?(:jpg) && !exts.include?(:jpeg)
          exts.push :jpeg
        end
        %r{(^http{1}[s]?://([w]{3}\.)?.+\.(#{exts.join('|')})(\?.+)?$)}i
      end

      def build_uri_regex
        {
          uri: %r{\b(
                (((ht|f)tp[s]?://)|([a-z0-9]+\.))+
                (?<!@)
                ([a-z0-9\_\-]+)
                (\.[a-z]+)+
                ([\?/\:][a-z0-9_=%&@\?\./\-\:\#\(\)]+)?
                /?
              )}ix,
          protocol: /((ht|f)tp[s]?)/i
        }
      end
    end
  end
end

