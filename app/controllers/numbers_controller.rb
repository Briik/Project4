class NumbersController < ApplicationController
    def index
        @total_num = formatted_number(Contract.sum(:dollar_amt))
        render json: { value: @totalNum }
    end
  end
