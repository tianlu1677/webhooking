class AddAttributesToWebhook < ActiveRecord::Migration[6.1]
  def change
    add_column :webhooks, :resp_code, :integer, default: 200
    add_column :webhooks, :resp_body, :string, default: ''
    add_column :webhooks, :resp_content_type, :string, default: 'text/plain'
  end
end
