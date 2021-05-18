class AddWebhookTokenToAccountTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :account_tokens, :webhook_token, :string
    add_column :account_tokens, :user_id, :integer
  end
end
