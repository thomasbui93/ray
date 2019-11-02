class CreateConfigurationValues < ActiveRecord::Migration[6.0]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :universal_key
      t.timestamps
    end

    create_table :accounts do |t|
      t.string :name, null: false
      t.string :universal_key
      t.timestamps
    end

    create_table :configuration_values do |t|
      t.string :path, null: false
      t.text :value, null: false
      t.belongs_to :application, foreign_key: true
      t.belongs_to :account, foreign_key: true
      t.timestamps
    end

    add_index :accounts, :universal_key
    add_index :applications, :universal_key
    add_index :configuration_values, [:application, :account]
  end
end
