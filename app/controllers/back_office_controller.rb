# frozen_string_literal: true

class BackOfficeController < ApplicationController
  before_action :authenticate_user!
end
