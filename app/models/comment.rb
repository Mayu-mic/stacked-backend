class Comment < ApplicationRecord
  has_many :likes, class_name: 'CommentLike'
  belongs_to :stack, counter_cache: 'comment_count'
  belongs_to :created_by, class_name: 'User'

  attr_accessor :current_user

  def liked
    if current_user
      !!likes.find { |like| like.created_by == current_user }
    else
      false
    end
  end
end
