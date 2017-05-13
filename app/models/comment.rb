class Comment < ApplicationRecord
  has_many :stars, class_name: 'CommentStar'
  belongs_to :item
  belongs_to :created_by, class_name: 'User', foreign_key: 'uid'
end
