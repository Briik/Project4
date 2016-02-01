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
          @totalNum = formatted_number(Contract.sum(:dollar_amt))
		  render json: {value: @totalNum}
      end
  end
# this is no longer used by the app :( Shifted workload to user :)
