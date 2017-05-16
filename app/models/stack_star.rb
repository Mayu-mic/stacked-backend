class StackStar < ApplicationRecord
  belongs_to :stack, counter_cache: 'star_count'
  belongs_to :created_by, class_name: 'User'
end
