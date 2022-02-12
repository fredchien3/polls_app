class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :question_id, :poll_id
  end
end
