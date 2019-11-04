class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow_user, class_name: 'User'

  validate :user_id, presence: true
  validate :follow_user_id, presence: true
end
