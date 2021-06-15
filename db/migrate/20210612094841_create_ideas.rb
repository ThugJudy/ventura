class CreateIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :decription
      t.string :domain
      t.decimal :stake
      t.references :user

      t.timestamps
    end
  end
end
