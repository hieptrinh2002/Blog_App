class ChangeComments < ActiveRecord::Migration[7.1]
  def change
    change_table :comments do |t|
      t.remove_references :post, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
    end
  end
end
