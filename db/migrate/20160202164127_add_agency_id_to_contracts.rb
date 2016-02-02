class AddAgencyIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :agency_id, :integer
  end
end
