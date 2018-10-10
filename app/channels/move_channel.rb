class MoveChannel < ApplicationCable::Channel
  def subscribed
    stream_from "move_channel_#{params[:game_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
