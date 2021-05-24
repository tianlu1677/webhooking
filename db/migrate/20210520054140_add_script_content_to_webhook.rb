class AddScriptContentToWebhook < ActiveRecord::Migration[6.1]
  def change
    add_column :webhooks, :script_content, :text
  end
end
