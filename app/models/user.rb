class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :callab_wikis, through: :collaborations, class_name: 'Wiki'

  after_initialize :default_role

  def default_role
    self.role ||= :standard
  end

# is this needed to gather if a user is a collaborator?
  def collaborator_for(wiki)
    collaborators.where(wiki_id: wiki.id).first
  end

  enum role: [:standard, :premium, :admin]
end
