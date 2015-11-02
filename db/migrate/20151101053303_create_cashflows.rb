class CreateCashflows < ActiveRecord::Migration
  def change
    create_table :cashflows do |t|
      t.float :flow
      t.float :year

      t.timestamps null: false
    end
  end
end
