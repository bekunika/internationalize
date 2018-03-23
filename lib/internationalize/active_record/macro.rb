module Internationalize
  module ActiveRecord
    module Macro
      def internationalize(*attr_names)
        options = attr_names.extract_options!
        # Bypass setup_translates! if the initial bootstrapping is done already.
        setup_translates!(options, attr_names) unless translates?
      end

      def translates?
        included_modules.include?(InstanceMethods)
      end

      def class_name
        @class_name ||= begin
          class_name = table_name[table_name_prefix.length..-(table_name_suffix.length + 1)].downcase.camelize
          pluralize_table_names ? class_name.singularize : class_name
        end
      end

      private

      def apply_globalize_options(options)
        options[:table_name] ||= "#{table_name.singularize}_translations"
        options[:foreign_key] ||= class_name.foreign_key

        class_attribute :translated_attribute_names, :translation_options, :fallbacks_for_empty_translations
        self.translated_attribute_names = []
        self.translation_options        = options
        self.fallbacks_for_empty_translations = options[:fallbacks_for_empty_translations]
      end

      def setup_translates!(options, translated_attrs)
        apply_globalize_options(options)

        include InstanceMethods
        extend  ClassMethods

        translation_class.table_name = options[:table_name]

        has_many :translations, class_name: translation_class.name,
                                foreign_key: options[:foreign_key],
                                dependent: :destroy,
                                autosave: true,
                                inverse_of: :internationalize_model

        accepts_nested_attributes_for :translations,
                                      allow_destroy: true,
                                      reject_if: proc { |attrs| translated_attrs.all? { |k| attrs[k.to_s].blank? } }

        validate :validate_having_translations

        translated_attrs.each do |field|
          define_method :"#{field}=" do |value|
            translation.send(:"#{field}=", value)
          end
          define_method :"#{field}" do
            translation.send(:"#{field}")
          end
        end
        self.translated_attribute_names = translated_attrs
      end
    end
  end
end
