class User < ActiveRecord::Base
  after_initialize :init
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis
  has_many :collaborations
  has_many :collaborating_wikis, through: :collaborations, source: :wiki
  
  def init
    self.role ||= "free"
  end

  def admin?
    role == 'admin'
  end

  def free?
    role == 'free'
  end

  def premium?
    role == 'premium'
  end
end
