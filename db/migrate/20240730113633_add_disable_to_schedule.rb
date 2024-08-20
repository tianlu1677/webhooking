class AddDisableToSchedule < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :disable, :boolean, default: false
  end
end
