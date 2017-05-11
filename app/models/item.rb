class Item < ApplicationRecord
  belongs_to :list
  belongs_to :created_by, class_name: 'User'
end
