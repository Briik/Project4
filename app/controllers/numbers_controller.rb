class NumbersController < ApplicationController
    def index
        @totalNum = formatted_number(Contract.sum(:dollar_amt))
        render json: { value: @totalNum }
    end
  end
