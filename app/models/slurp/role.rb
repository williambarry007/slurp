
class Slurp::Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions
  attr_accessible :name, :description, :parent_id
  attr_accessor :children
   
  def is_allowed(resource, action)
    for perm in permissions
      return true if (perm.resource == resource && perm.action == action)
      return true if (perm.resource == "all" && perm.action == "all")
    end
    return false
  end		
  
  def children
    return Role.where(:parent_id => id).reorder("name").all
  end
  
  #-----------------------------------------------------------------------------
  # Class methods
  #-----------------------------------------------------------------------------
  
  def self.roles_with_user(user_id)
    return Role.where("users.id" => user_id).all(:include => :users)
  end
  
  def self.tree
    return Role.where(:parent_id => -1).reorder("name").all
  end
    
end
