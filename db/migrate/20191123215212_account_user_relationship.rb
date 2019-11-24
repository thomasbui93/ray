class AccountUserRelationship < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :password
      t.string :universal_key
      t.boolean :is_external
      t.timestamps
    end

    create_join_table :users, :accounts do |t|
      t.integer :role, default: 0
      t.index :user_id
      t.index :account_id
    end
  end
end
