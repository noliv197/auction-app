class HomeController < ApplicationController
    def index
        @in_progress_lot = Lot.where("limit_date > ? and start_date <= ? and status = ?",Date.today,Date.today,1)
        @future_lot = Lot.where("start_date > ? AND status = ?",Date.today,1)
    end
end