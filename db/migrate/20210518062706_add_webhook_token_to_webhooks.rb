class AddWebhookTokenToWebhooks < ActiveRecord::Migration[6.1]
  def change
    add_column :webhooks, :webhook_token, :string
    add_column :webhooks, :user_id, :integer
  end
end
