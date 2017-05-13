class User < ActiveRecord::Base
  # Include default devise modules.
  devise :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
