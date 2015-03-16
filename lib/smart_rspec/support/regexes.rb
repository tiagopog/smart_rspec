module SmartRspec
  module Support
    module Regexes
      @@uri_regexes =
        { protocol: /((ht|f)tp[s]?)/i,
          uri: %r{^(
                (((ht|f)tp[s]?://)|([a-z0-9]+\.))+
                (?<!@)
                ([a-z0-9\_\-]+)
                (\.[a-z]+)+
                ([\?/\:][a-z0-9_=%&@\?\./\-\:\#\(\)]+)?
                /?
              )$}ix }

      def build_regex(type, *args)
        case type.to_sym
        when :email then /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        when :image then build_img_regex(args)
        else @@uri_regexes[type]
        end
      end

      private_class_method

      def build_img_regex(exts = [])
        exts = [exts].flatten
        if exts.nil? || exts.empty?
          exts = %w(jpg jpeg png gif)
        elsif exts.include?(:jpg) && !exts.include?(:jpeg)
          exts.push :jpeg
        end
        %r{(^http{1}[s]?://([w]{3}\.)?.+\.(#{exts.join('|')})(\?.+)?$)}i
      end
    end
  end
end

