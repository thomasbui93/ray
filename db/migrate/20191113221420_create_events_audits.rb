class CreateEventsAudits < ActiveRecord::Migration[6.0]
  def change
    create_table :events_audits do |t|
      t.string :entity_type, null: false
      t.string :audit_type, null: false
      t.json :payload, null: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :entity_id, null: false
    end

    add_index :events_audits, [:entity_type, :entity_id]
  end
end
