class ContractsController < ApplicationController
	def formatted_number(n)
		if !n
			return 0
		else
	  	a,b = sprintf("%0.2f", n).split('.')
	  	a.gsub!(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
	  	"$#{a}.#{b}"
		end
  	end
	  def index
		  @contracts = Contract.all
		  @contractsJSON = @contracts.to_json
          @totalNum = formatted_number(Contract.sum(:dollar_amt))
	  end

	  def show
		  @contract = Contract.find(params[:id])
		  @money = formatted_number(@contract.dollar_amt)
      end

	  def json
		  render json: Contract.all.to_json, status: :ok
	  end

	  def angular_index
	  end
end
