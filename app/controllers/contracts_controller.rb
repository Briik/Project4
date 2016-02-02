class ContractsController < ApplicationController
    def index
        @contracts = Contract.all
        @contracts_JSON = @contracts.to_json
        @total_num = formatted_number(Contract.sum(:dollar_amt))
        respond_to do |format|
            format.html  # show.html.erb
            format.json  { render :json => @pcontracts }
        end
    end

    def show
        @contract = Contract.find(params[:id])
        @agency = Agency.find("name: ")
        @money = formatted_number(@contract.dollar_amt)
        respond_to do |format|
            format.html  # show.html.erb
            format.json  { render :json => @contract }
        end
    end

    def json
        render json: Contract.all.to_json, status: :ok
    end
end
