require 'active_record'

module Internationalize
  autoload :ActiveRecord, 'internationalize/active_record'
end

ActiveRecord::Base.extend(Internationalize::ActiveRecord::Macro)