class CommentLike < ApplicationRecord
  belongs_to :comment, counter_cache: 'like_count'
  belongs_to :created_by, class_name: 'User'
end
