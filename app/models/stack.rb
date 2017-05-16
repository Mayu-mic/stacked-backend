class Stack < ApplicationRecord
  has_many :stars, class_name: 'StackStar'
  has_many :comments
  belongs_to :list
  belongs_to :created_by, class_name: 'User'

  enum status: [:pending, :in_progress, :resolved]
end