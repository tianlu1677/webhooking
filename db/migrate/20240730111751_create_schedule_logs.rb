class CreateScheduleLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_logs do |t|
      t.integer :response_status
      t.jsonb :response_headers, default: {}
      t.text :response_body
      t.text :request
      t.text :error
      t.integer :schedule_id

      t.timestamps
    end

    add_index :schedule_logs, :schedule_id
  end
end
