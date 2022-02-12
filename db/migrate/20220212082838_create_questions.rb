class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :question_id, null: false, index: true

      t.timestamps
    end
  end
end
