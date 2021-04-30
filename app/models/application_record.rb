class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  extend Enumerize
  include Redis::Objects
  
  # example:  enumerize :from_source, in: [:by_self, :by_spider], default: :by_self
end
