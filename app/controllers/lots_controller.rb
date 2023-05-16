class LotsController < ApplicationController
    before_action :authenticate_user!, only:[:new,:pending,:edit,:create]
    before_action :check_credentials, only:[:new,:create,:pending,:approved,:edit,:create]
    def show
        @lot = Lot.find(params[:id])
    end
    def new
        @lot = Lot.new
    end
    def pending
        @lots = Lot.pending
    end
    def approved
        @lots = Lot.pending
        @lot = Lot.find(params[:id])
        if @lot.created_by == current_user
            flash.now[:notice] = 'Outro administrador precisa executar essa ação'
            render :pending
        elsif @lot.item_models.empty?
            flash.now[:notice] = 'Lote precisa de pelo menos 1 item'
            render :pending
        else    
            @lot.approved!
            @lot.approved_by = current_user
            flash.now[:notice] = 'Lote Aprovado com Sucesso'
            render :pending
        end
    end
    def create
        @lot = Lot.new(lot_params)
        @lot.created_by = current_user
        if @lot.save
            return redirect_to @lot, notice: 'Lote criado com sucesso!'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o lote'
            render :new, status: 422
        end
    end
    def edit
        @lot = Lot.find(params[:id])
        if !@lot.pending?
            return redirect_to @lot, notice: 'Lote não pode mais ser editado'
        end
    end
    def update
        @lot = Lot.find(params[:id])
        if !@lot.pending?
            return redirect_to @lot, notice: 'Lote não pode mais ser editado'
        elsif @lot.update(lot_params)
            return redirect_to @lot, notice: 'Lote atualizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possivel salvar as alterações'
            render :edit, status: 422
        end
    end

    private
    def check_credentials
        if current_user.client?
            return redirect_to root_path, notice: 'Você não tem permissão para executar essa ação'
        end
    end
    def lot_params
        params.require(:lot).permit(
            :code,:start_date,:limit_date,:image,
            :minimum_bid,:bids_difference
        )
    end
end