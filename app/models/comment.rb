class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :created_by, class_name: 'User'
end
