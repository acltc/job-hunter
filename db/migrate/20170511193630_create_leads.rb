class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company
      t.string :linkedin_url
      t.boolean :email_sent, default: false
      t.boolean :meeting_set, default: false
      t.boolean :interview_set, default: false
      t.boolean :job_offer, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
