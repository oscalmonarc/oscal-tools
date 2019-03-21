require './lib/monarc/shared_functions'
require './lib/monarc/shared_model_functions'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include SharedFunctions
  include SharedModelFunctions
end
