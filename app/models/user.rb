class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :interests
  has_and_belongs_to_many :tags
  has_many :time_tables
  has_many :bookmarks
  has_and_belongs_to_many :conversations
  mount_uploader :avatar, AvatarUploader
end
