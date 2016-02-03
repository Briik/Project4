class AgenciesController < ApplicationController
    def index
        @agencies = Agency.all
    end
    def show
        @agency = Agency.find(params[:id])
        @contracts = Contract.where agency_id: params[:id]
        @totalVal = formatted_number(Contract.where(agency_id: params[:id]).sum(:dollar_amt))
    end
end
