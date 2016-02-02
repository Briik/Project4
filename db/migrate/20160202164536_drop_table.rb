class DropTable < ActiveRecord::Migration
  def change
      drop_table :agencies_contracts
  end
end
