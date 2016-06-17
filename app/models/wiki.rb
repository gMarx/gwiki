class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :collab_users, through: :collaborators, class_name: 'User'
end
