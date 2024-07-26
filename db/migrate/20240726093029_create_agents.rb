class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :type
      t.string :name
      t.integer :webhook_id
      t.jsonb :options, default: {}
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :agents, :webhook_id
  end
end
