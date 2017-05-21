class StackLike < ApplicationRecord
  belongs_to :stack, counter_cache: 'like_count'
  belongs_to :created_by, class_name: 'User'
end
