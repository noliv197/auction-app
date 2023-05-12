class LotsController < ApplicationController
    before_action :authenticate_user!, only:[:new]
    before_action :check_credentials, only:[:new,:create]
    def show
        @lot = Lot.find(params[:id])
    end
    def new
        @lot = Lot.new
    end
    def create
        lot_params = params.require(:lot).permit(
            :code,:start_date,:limit_date,
            :minimum_bid,:bids_difference
        )
        @lot = Lot.new(lot_params)
        if @lot.save
            return redirect_to @lot, notice: 'Lote criado com sucesso!'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o lote'
            render :new, status: 422
        end
    end

    private
    def check_credentials
        if current_user.client?
            return redirect_to root_path, notice: 'Você não tem permissão para executar essa ação'
        end
    end
end