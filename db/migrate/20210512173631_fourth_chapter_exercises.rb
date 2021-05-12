class FourthChapterExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_cancellations, id: :uuid do |t|
      t.uuid :payment_id, null: false
      t.timestamps
    end

    add_index :payment_cancellations, :payment_id, unique: true
  end
end
