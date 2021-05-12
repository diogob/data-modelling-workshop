class SecondChapterExercises < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
    add_index :repositories, [:user_id, :name], unique: true
    # 1 ssh key per user was already enforced as an unique index in the previous migration
    add_index :ssh_keys, :key, unique: true
  end
end
