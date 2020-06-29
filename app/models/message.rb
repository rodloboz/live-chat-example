class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat, touch: true

  validates_presence_of :body, :chat_id, :user_id

  def message_time
    created_at.strftime("%d %b, %Y")
  end

  def other_user
    chat.other_user(user)
  end
end