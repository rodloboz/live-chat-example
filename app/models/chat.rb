class Chat < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :involving, -> (user) {
    where("chats.sender_id = ? OR chats.recipient_id = ?", user.id, user.id)
  }

  scope :between, -> (user_a, user_b) {
    sql = "(chats.sender_id = :user_a AND chats.recipient_id = :user_b) "\
          "OR (chats.sender_id = :user_a AND chats.recipient_id = :user_b)"
    where(sql, user_a: user_a, user_b: user_b)
  }

  scope :by_recent_message, -> { order(updated_at: :desc) }

  def other_user(user)
    user == sender ? recipient : sender
  end

  def last_message
    messages.last
  end
end