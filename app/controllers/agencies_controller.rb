class AgenciesController < ApplicationController
    def index
        @agencies = Agency.all.order(name: :asc)
        @total_num = formatted_number(Contract.sum(:dollar_amt))
    end
    def show
        @agency = Agency.find(params[:id])
        @contracts = Contract.where agency_id: params[:id]
        values = Contract.where(agency_id: params[:id]).sum(:dollar_amt)
        @total_val = formatted_number(values)
        @percent_val = (values / Contract.sum(:dollar_amt)) * 100
        @contracts_JSON = @contracts.to_json
    end
end
