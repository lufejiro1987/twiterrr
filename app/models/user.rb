class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  validates_presence_of :profile_img_url

  has_many :tweets
  has_many :likes

  protected

  def serializable_hash(options = nil)
    super(options).merge(profile_img_url: profile_img_url)
  end

end
