class FirstChapterExercises < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :email, false
    change_column_null :users, :password, false
    remove_column :users, :ssh_key
    remove_column :users, :ssh_key_name
    remove_column :users, :ssh_key_created_at

    create_table :ssh_keys, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.text :name, null: false
      t.text :key, null: false

      t.timestamps
    end

    add_foreign_key :ssh_keys, :users
    add_index :ssh_keys, :user_id, unique: true
  end
end
