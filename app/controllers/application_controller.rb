class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    helper_method :formatted_number

    def formatted_number(n)
        if !n
            return 0
        else
            a, b = sprintf('%0.2f', n).split('.')
            a.gsub!(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
            "$#{a}.#{b}"
        end
      end
end
