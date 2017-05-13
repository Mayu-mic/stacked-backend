class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
