# frozen_string_literal: true

class User < ApplicationRecord
  # Email of the demo user created by db/seeds.rb
  SEED_EMAIL = "user@example.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :access_grants,
           class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :oauth_applications,
           class_name: "Doorkeeper::Application",
           as: :owner

  has_many :projects, dependent: :delete_all

  def seed?
    email == SEED_EMAIL
  end
end
