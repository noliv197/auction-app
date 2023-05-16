class LotItemsController < ApplicationController
    def new
        @lot = Lot.find(params[:lot_id])
        @lot_item = LotItem.new
        @items = ItemModel.available 
    end
    def create
        @lot = Lot.find(params[:lot_id])
        lot_item_params = params.require(:lot_item).permit(:item_model_id)
        @lot_item = LotItem.new(lot_item_params)
        @lot_item.lot = @lot

        if @lot_item.save
            @lot_item.item_model.unavailable!
            return redirect_to @lot, notice: 'Item adicionado com sucesso!'
        else
            @items = ItemModel.available
            flash.now[:notice] = 'Não foi possivel adicionar o item'
            render :new, status: 422
        end
    end
    def destroy
        lot = Lot.find(params[:lot_id])
        item = ItemModel.find(params[:id])
        lot_item = item.lot_item
        if lot_item.destroy
            item.available!
            return redirect_to lot_path(lot), notice: 'Item deletado com sucesso!'
        else 
            return redirect_to lot_path(lot), notice: 'Não foi possivel remover o item'
        end
    end
end