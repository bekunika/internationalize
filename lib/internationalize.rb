module Internationalize
end

ActiveRecord::Base.extend(Internationalize::ActiveRecord::Macro)