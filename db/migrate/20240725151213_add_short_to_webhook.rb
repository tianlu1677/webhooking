class AddShortToWebhook < ActiveRecord::Migration[7.0]
  def change
    add_column :webhooks, :short, :string
    add_index :webhooks, :short, unique: true
  end
end
