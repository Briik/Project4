class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.string :link
      t.string :description
      t.datetime :pubdate
      t.decimal :dollar_amt, precision: 16, scale: 2
      t.string :creator
    end
  end
end
