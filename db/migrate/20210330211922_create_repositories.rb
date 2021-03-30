class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.text :name, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_foreign_key :repositories, :users
  end
end
