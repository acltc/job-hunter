class LeadsController < ApplicationController

  def index
    @leads = current_user.leads
  end

end