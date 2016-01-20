class NumbersController < ApplicationController
    def formatted_number(n)
		if !n
			return 0;
		elsif n
	  	a,b = sprintf("%0.2f", n).split('.')
	  	a.gsub!(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
	  	"$#{a}.#{b}"
	  end
  end
      def index
          @contracts = Contract.all
          def get_num
			  tot = 0
		  	@contracts.each do |a|
			  tot += a.dollar_amt.to_i
		  	end
			  return tot
		  end
          @totalNum = formatted_number(get_num)
		  render json: {value: @totalNum}
      end
  end
# this is no longer used by the app :( Shifted workload to user :)
