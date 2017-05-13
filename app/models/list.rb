class List < ApplicationRecord
  has_many :items
  belongs_to :created_by, class_name: 'User', foreign_key: 'uid'

  enum status: [:active, :archived]
end
