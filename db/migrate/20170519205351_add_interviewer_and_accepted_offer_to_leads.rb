class AddInterviewerAndAcceptedOfferToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :interviewer_name, :string
    add_column :leads, :offer_status, :string
  end
end
