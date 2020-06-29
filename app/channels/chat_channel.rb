class ChatChannel < ApplicationCable::Channel
  def subscribed
    Chat.involving(current_user).each do |chat|
      # stream_from "chat_#{chat.id}"
      stream_for chat
    end
  end

  def unsubscribed
    stop_all_streams
  end
end