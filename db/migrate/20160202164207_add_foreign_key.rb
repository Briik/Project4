class AddForeignKey < ActiveRecord::Migration
  def change
      add_foreign_key :contracts, :agencies
  end
end
