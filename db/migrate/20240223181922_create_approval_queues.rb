class CreateApprovalQueues < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_queues do |t|
      t.integer :product_id
      t.datetime :request_date
      t.string :approval_status

      t.timestamps
    end
  end
end
