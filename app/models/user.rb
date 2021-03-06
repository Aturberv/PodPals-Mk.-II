class User < ApplicationRecord
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :podcast_users
  has_many :podcasts, through: :podcast_users
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :shares
  has_many :sent_shares, :class_name => "Share", :foreign_key => "sender_id"
  has_many :recieved_shares, :class_name => "Share", :foreign_key => "recipient_id"
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },
    :default_url => ":style/default_profile_picture.png"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :username, presence: true, uniqueness: true
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  def accepted_inverse_friends
    self.inverse_friendships.where(pending: false)
  end

  def accepted_friends
    self.friendships.where(pending: false)
  end

  def online?
    self.online
  end

  def inverse_pending_friends
    self.inverse_friendships.where(pending: true)
  end

  def pending_friends
    self.friendships.where(pending: true)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
