class CreateCustomActionLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :custom_action_logs do |t|
      t.integer :webhook_id
      t.integer :from_custom_action_id
      t.integer :next_custom_action_id
      t.integer :backpack_id
      t.jsonb :original_params
      t.jsonb :custom_params

      t.timestamps
    end
  end
end
