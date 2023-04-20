class CreatePostalCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :postal_codes do |t|
      t.string :full
      t.string :code
      t.string :plus
      t.integer :rate

      t.timestamps
    end
  end
end
