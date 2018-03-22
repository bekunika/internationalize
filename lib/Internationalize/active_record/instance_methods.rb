module Internationalize
  module ActiveRecord
    module InstanceMethods
      def id=(value)
        if id
          translations.each do |translation|
            translation.preparation_id = value
          end
        end
        super
      end

      def validate_having_translations
        errors.add(:base, :without_translates) if translations.empty?
      end

      def locale(locale)
        translation = translations.select { |tr| tr.locale.to_s == locale.to_s }.first
        translation || translations.where(locale: locale).first_or_initialize
      end

      def translation
        locale I18n.locale
      end
    end
  end
end
