class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.references :employee, null: false, foreign_key: true
      t.references :feedbackable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
