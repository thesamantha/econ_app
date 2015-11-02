class CreateDiagrams < ActiveRecord::Migration
  def change
    create_table :diagrams do |t|
      t.float :investment
      t.float :MARR
      t.float :capacity
      t.float :pur
      t.float :puc
      t.float :om
      t.float :salv
      t.float :horiz
      t.float :deprec_time
      t.boolean :deprec_type
      t.float :DB_per
      t.float :loan_amt
      t.float :loan_time
      t.float :loan_interest_rate
      t.boolean :loan_type
      t.float :tax_rate

      t.timestamps null: false
    end
  end
end
