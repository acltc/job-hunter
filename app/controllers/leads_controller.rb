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
      @leads = Lead.all.order(created_at: :desc)
    else
      @leads = current_user.leads.order(created_at: :desc)
    end
  end

  def show
    @lead = Lead.find(params[:id])
  end

  def new
    @lead = Lead.new
  end

  def create
    @lead = current_user.leads.new(lead_params)
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
      redirect_to leads_path
    else
      render 'edit'
    end
  end

  def destroy
    @lead = Lead.find_by(id: params[:id])
    if current_user.admin? || current_user == @lead.user
      @lead.destroy
      flash[:success] = "Lead Destroyed"
    end
    redirect_to '/'
  end

  def interviews
    @interviews = Lead.where(interview_set: true)
  end

  def job_offers
    @job_offers = Lead.where(job_offer: true)
  end

  private

    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :company, :linkedin_url, :email_sent, :meeting_set, :interview_set, :job_offer)
    end

    def authorize_lead_owner
      @lead = Lead.find(params[:id])
      unless @lead.user_id == current_user.id || current_user.admin
        flash[:alert] = "You do not have access to that page."
        redirect_to leads_path
      end
    end

end
