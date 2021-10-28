class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.datetime :date
      t.boolean :buy
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :coin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
