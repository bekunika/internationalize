module Internationalize
  module ActiveRecord
    autoload :ClassMethods,    'internationalize/active_record/class_methods'
    autoload :InstanceMethods, 'internationalize/active_record/instance_methods'
    autoload :Macro,           'internationalize/active_record/macro'
    autoload :Translation,     'internationalize/active_record/translation'
  end
end
