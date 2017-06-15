class LeadsController < ApplicationController
  before_action :authenticate_user!
  before_action only: [:interviews, :job_offers] do
    unless current_user && current_user.admin?
      flash[:alert] = "You do not have access to that page."
      redirect_to leads_path
    end
  end
 
  def index
    if current_user && current_user.admin?
      @leads = Lead.all
    else
      @leads = current_user.leads
    end
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
      flash[:success] = "Lead saved!"
      redirect_to leads_path
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

  def interviews
    @interviews = Lead.where(interview_set: true)
  end

  def job_offers
    @job_offers = Lead.where(job_offer: true)
  end

  private

    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :company, :linkedin_url, :email_sent, :meeting_set, :interview_set, :job_offer, :user_id)
    end

    def authorize_lead_owner
      @lead = Lead.find(params[:id])
      unless @lead.user_id == current_user.id || current_user.admin
        flash[:alert] = "You do not have access to that page."
        redirect_to leads_path
      end
    end

end
