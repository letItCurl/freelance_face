# frozen_string_literal: true

class BackOfficeController < ApplicationController
  before_action :authenticate_user!
  before_action :save_ip

  private

  def save_ip
    @device = current_user.devices.where(remote_ip: request.remote_ip, user_agent: request.user_agent)&.first
    current_user.devices.create(remote_ip: request.remote_ip, user_agent: request.user_agent) if @device.nil?
  end
end
