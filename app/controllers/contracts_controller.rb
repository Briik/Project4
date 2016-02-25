class ContractsController < ApplicationController
    def index
        @contracts = Contract.all
        @contracts_JSON = @contracts.to_json
        @total_num = formatted_number(Contract.sum(:dollar_amt))
        @agencies = Agency.all.order(name: :asc)
        respond_to do |format|
            format.html  # show.html.erb
            format.json  { render :json => @contracts }
        end
    end

    def show
        @contract = Contract.find(params[:id])
        @agency = Agency.find_by id: @contract.agency_id
        @money = formatted_number(@contract.dollar_amt)
        @percent = '%.2f' % @contract.percent_val
        @percent_of_agency = '%.2f' % @contract.percent_of_agency
        respond_to do |format|
            format.html  # show.html.erb
            format.json  { render :json => @contract }
        end
    end

    def edit
        @contract = Contract.find(params[:id])
        def formlist
            result = Array.new
            Agency.all.each do |agency|
                agent = Array.new
                agent.push agency.name
                agent.push agency.id
                result.push agent
            end
            return result
        end
        @agencies = formlist
        @agency = Agency.find_by_id @contract.agency_id
    end

    def update
        @contract = Contract.find(params[:id])
        @agency = Agency.find(params[:agency_id])
        @contract.update(contracts_params.merge(agency: @agency))
        redirect_to '/'
      end

    def json
        render json: Contract.all.to_json, status: :ok
    end

    private
  def contracts_params
    params.require(:contract).permit(:title, :link, :description, :pubdate, :dollar_amt, :creator, :agency_id)
  end
end
