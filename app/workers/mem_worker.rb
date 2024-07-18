class MemWorker
  include Sidekiq::Worker

  def perform(id)
  	ActionCable.server.broadcast('members_channel', message: render_new(id))
  end

  def render_new(identification)
    ApplicationController.renderer.render(
      partial: 'memberships/new', locals: { card: identification})
  end
end
