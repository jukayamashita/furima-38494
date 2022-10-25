class CreateDestinationPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :destination_purchase_records do |t|

      t.timestamps
    end
  end
end
