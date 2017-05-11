class CommentStar < ApplicationRecord
  belongs_to :comment
  belongs_to :created_by, class_name: 'User'
end
