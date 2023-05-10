class HomeController < ApplicationController
    def index
        @in_progress_lot = Lot.where("start_date <= ? and status = ?",Date.today,1)
        @future_lot = Lot.where("start_date > ? AND status = ?",Date.today,1)
    end
end