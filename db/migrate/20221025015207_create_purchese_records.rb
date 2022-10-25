class CreatePurcheseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :purchese_records do |t|
      t.references     :product,       null: false, foreign_key: true
      t.references     :user,          null: false, foreign_key: true
      

      t.timestamps
    end
  end
end

