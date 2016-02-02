class CreateContractJoinTable < ActiveRecord::Migration
  def change
    create_join_table :contracts, :agencies do |t|
      # t.index [:contract_id, :agency_id]
      t.index [:agency_id, :contract_id], unique: true
    end
  end
end
