class ItemModelsController < ApplicationController
    before_action :authenticate_user!, only:[:new]
    before_action :check_credentials, only:[:new,:create]
    
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

    private
    def check_credentials
        if current_user.client?
            return redirect_to root_path, notice: 'Você não tem permissão para executar essa ação'
        end
    end
end