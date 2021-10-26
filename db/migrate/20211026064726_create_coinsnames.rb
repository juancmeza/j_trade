class CreateCoinsnames < ActiveRecord::Migration[6.1]
  def change
    create_table :coinsnames do |t|
      t.string :symbol
      t.decimal :amount
      t.datetime :purchase_date
      t.datetime :sell_date
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
