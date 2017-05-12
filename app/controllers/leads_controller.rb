class LeadsController < ApplicationController
  before_action :authenticate_user!
  # before_action :lead_owner, only: [:edit, :update]

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
    @lead = Lead.find(params[:id])
    @lead.user_id = @lead.user_id
  end

  def update
    @lead = Lead.find(params[:id])

    if @lead.update
      redirect_to @lead
    else
      render 'edit'
    end
  end

  private

    def lead_params
      parmas.require(:lead).permit(:first_name, :last_name, :email, :phone, :company, :linkedin_url, :email_sent, :meeting_set, :interview_set, :job_offer)
    end

    # def lead_owner
    #   unless @lead.user_id == current_user.id || current_user.admin
    #     flash[:notice] = 'Access Denied'
    #     redirect_to leads_path
    #   end
    # end

end
