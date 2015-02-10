class Group < ActiveRecord::Base
  has_many :tasks
  belongs_to :workspace
end
