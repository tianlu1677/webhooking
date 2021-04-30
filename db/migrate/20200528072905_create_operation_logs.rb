class CreateOperationLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :operation_logs do |t|
      t.string :user_id
      t.string :params
      t.string :action
      t.string :controller

      t.timestamps
    end
  end
end
