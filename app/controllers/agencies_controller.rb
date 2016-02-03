class AgenciesController < ApplicationController
    def index
        @agencies = Agency.all
        @@total_num = formatted_number(Contract.sum(:dollar_amt))
    end
    def show
        @agency = Agency.find(params[:id])
        @contracts = Contract.where agency_id: params[:id]
        @totalVal = formatted_number(Contract.where(agency_id: params[:id]).sum(:dollar_amt))
    end
end
