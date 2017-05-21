class Stack < ApplicationRecord
  has_many :stars, class_name: 'StackStar'
  has_many :comments
  belongs_to :list
  belongs_to :created_by, class_name: 'User'

  enum status: [:pending, :in_progress, :resolved]

  attr_accessor :current_user

  def liked
    if current_user
      !!stars.find { |star| star.created_by == current_user }
    else
      false
    end
  end

end
