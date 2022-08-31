class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :lists,     dependent: :destroy
  has_many :items,     dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_lists, through: :favorites, source: :list
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :reverse_of_follows, source: :follower

  validates :user_name, presence: true, length: { maximum: 10 }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください(半角)'

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def follow(user_id)
    follows.create(followed_id: user_id)
  end
  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

end
