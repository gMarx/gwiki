class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  after_initialize :default_role

  def default_role
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]
end
