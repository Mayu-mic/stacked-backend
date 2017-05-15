class ItemStar < ApplicationRecord
  belongs_to :item, counter_cache: 'star_count'
  belongs_to :created_by, class_name: 'User'
end
