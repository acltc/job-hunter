class LeadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @leads = current_user.leads
  end

  def show
    @lead = Lead.find(params[:id])
  end

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      redirect_to @lead
    else
      render 'new'
    end
  end

  def edit
    authorize_lead_owner
  end

  def update
    authorize_lead_owner
    if @lead.update(lead_params)
      redirect_to @lead
    else
      render 'edit'
    end
  end

  private

    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :company, :linkedin_url, :email_sent, :meeting_set, :interview_set, :job_offer, :user_id)
    end

    def authorize_lead_owner
      @lead = Lead.find(params[:id])
      unless @lead.user_id == current_user.id || current_user.admin
        flash[:notice] = 'Access Denied'
        redirect_to leads_path
      end
    end

end
