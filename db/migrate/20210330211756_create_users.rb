class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.text :email
      t.text :password
      t.text :ssh_key
      t.text :ssh_key_name
      t.text :ssh_key_created_at
      t.timestamps
    end
  end
end
