class BidsController < ApplicationController
    before_action :authenticate_user!, only:[:create]
    def create
        bid_params = params.require(:bid).permit(:value)
        @lot = Lot.find(params[:lot_id])
        @bid = Bid.new(bid_params)
        @bid.lot = @lot
        @bid.user = current_user

        if @bid.save
            @lot.update(last_bid: @bid.value)
            return redirect_to @lot, notice: 'Lance feito com sucesso'
        else
            return redirect_to @lot, notice: 'Não foi possível completar seu lance'
        end
    end
end