class CommentStar < ApplicationRecord
  belongs_to :comment, counter_cache: 'star_count'
  belongs_to :created_by, class_name: 'User'
end
