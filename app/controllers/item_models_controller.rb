class ItemModelsController < ApplicationController
    def show
        @item_model = ItemModel.find(params[:id])
    end
    def new
        @item_model = ItemModel.new
    end
    def create
        item_model_params = params.require(:item_model).permit(
            :name,:description,:image,
            :weight,:length,:width,:depth,:category
        )
        @item_model = ItemModel.new(item_model_params)
        if @item_model.save
            return redirect_to @item_model, notice: 'Item criado com sucesso!'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o item'
            render :new, status: 422
        end
    end
end