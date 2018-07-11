module Internationalize
  module ActiveRecord
    module ClassMethods
      def translation_class
        @translation_class ||= begin
          klass = if const_defined?(:Translation, false)
                    const_get(:Translation, false)
                  else
                    const_set(:Translation, Class.new(Internationalize::ActiveRecord::Translation))
                  end

          klass.belongs_to :internationalize_model,
                           class_name: name,
                           foreign_key: translation_options[:foreign_key],
                           inverse_of: :translations

          klass.validates :locale, uniqueness: { scope: translation_options[:foreign_key] }

          klass
        end
      end
    end
  end
end
