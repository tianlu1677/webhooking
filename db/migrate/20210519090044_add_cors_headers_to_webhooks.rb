class AddCorsHeadersToWebhooks < ActiveRecord::Migration[6.1]
  def change
    add_column :webhooks, :cors_enabled, :boolean, default: true
  end
end
