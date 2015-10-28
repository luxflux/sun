class ActionLogEntriesController < ApplicationController
  def index
    @port = Port.find(params[:port_id])
    @action_log_entries = @port.action_log_entries.order(created_at: :desc).limit(100)
  end
end
