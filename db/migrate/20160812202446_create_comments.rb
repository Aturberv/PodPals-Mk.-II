class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id, foreign_key: true, index: true
      t.integer :commentable_id, index: true
      t.string :commentable_type

      t.timestamps
    end
  end
end
