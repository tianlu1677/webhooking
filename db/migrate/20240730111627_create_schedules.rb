class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :name
      t.string :interval
      t.string :request_url
      t.string :request_method
      t.text :request_body
      t.jsonb :request_headers
      t.string :request_status_min
      t.string :request_status_max
      t.integer :user_id
      t.string :cron
      t.datetime :last_run_at
      t.integer :last_run_status

      t.timestamps
    end
  end
end
