class ChangeVaultToAdjacencyList < ActiveRecord::Migration[6.0]
  def up
    add_column :configuration_values, :parent_id, :integer
    add_foreign_key :configuration_values,
      :configuration_values,
      column: :parent_id,
      on_delete: :cascade,
      on_update: :cascade
  end

  def down
    remove_column :configuration_values, :parent_id
  end
end
