class List < ApplicationRecord
  has_many :items
  belongs_to :created_by, class_name: 'User'

  enum status: [:active, :archived]

  def is_system?
    self.is_system
  end
end
