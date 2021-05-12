class ThirdChapterExercises < ActiveRecord::Migration[6.1]
  def change
    execute "CREATE DOMAIN positive_numeric AS numeric CHECK (VALUE > 0)"

    create_table :subscriptions, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.column :price, :positive_numeric, null: false
      t.timestamp :deactivated_at, null: true

      t.timestamps
    end

    add_index :subscriptions, [:created_at, :user_id], unique: true
    add_index :subscriptions, :user_id, where: "deactivated_at IS NULL", unique: true

    create_table :payments, id: :uuid do |t|
      t.uuid :subscription_id, null: false
      t.timestamps
    end

    add_index :payments, [:created_at, :subscription_id], unique: true
  end
end
