class AddRedirectUrlToWebhook < ActiveRecord::Migration[7.1]
  def change
    add_column :webhooks, :redirect_url, :string
  end
end
