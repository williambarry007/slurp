
class Slurp::Permission < ActiveRecord::Base
  attr_accessible :action, :resource
  has_and_belongs_to_many :roles
end
