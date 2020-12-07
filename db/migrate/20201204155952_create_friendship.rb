class CreateFriendship < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :first_friend, foreign_key: { to_table: :users }, index: true
      t.references :second_friend, foreign_key: { to_table: :users }, index: true

      t.timestamps null: false
    end
  end
end
