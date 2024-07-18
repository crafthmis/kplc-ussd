class MembersChannel < ApplicationCable::Channel
  def subscribed
     stream_from "members_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end


