class Comment < ApplicationRecord
  has_many :stars, class_name: 'CommentStar'
  belongs_to :stack
  belongs_to :created_by, class_name: 'User'
end
