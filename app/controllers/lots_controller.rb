class LotsController < ApplicationController
    before_action :authenticate_user!, only:[:new,:pending,:edit,:create,:to_close,:result]
    before_action :check_admin_credentials, only:[:new,:create,:pending,:approved,:edit,:create,:to_close,:canceled,:closed]
    before_action :check_client_credentials, only:[:result]
    def show
        @lot = Lot.find(params[:id])
    end
    def new
        @lot = Lot.new
    end
    def result
        @lots = Lot.closed
        @bids = current_user.bids.map {|bid| bid.lot_id}
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
    def to_close
        @to_close_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NOT NULL",Date.today,1)
        @to_cancel_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NULL",Date.today,1)
    end
    def canceled
        @to_close_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NOT NULL",Date.today,1)
        @to_cancel_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NULL",Date.today,1)
        @lot = Lot.find(params[:id])
 
        @lot.canceled!
        @lot.lot_items.each do |i|
            i.item_model.available!
            i.destroy
        end
        @lot.item_models
        flash.now[:notice] = 'Lote Cancelado com Sucesso'
        render :to_close
    end
    def closed
        @to_close_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NOT NULL",Date.today,1)
        @to_cancel_lots = Lot.where("limit_date <= ? AND status = ? AND last_bid IS NULL",Date.today,1)
        @lot = Lot.find(params[:id])
 
        @lot.closed!
        @lot.lot_items.each do |i|
            i.item_model.sold!
        end
        flash.now[:notice] = 'Lote Encerrado com Sucesso'
        render :to_close
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
    def check_admin_credentials
        if current_user.client?
            return redirect_to root_path, notice: 'Você não tem permissão para executar essa ação'
        end
    end
    def check_client_credentials
        if current_user.admin?
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