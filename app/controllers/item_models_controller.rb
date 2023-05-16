class ItemModelsController < ApplicationController
    before_action :authenticate_user!, only:[:new,:edit,:update]
    before_action :check_credentials, only:[:new,:create,:edit,:update]
    
    def show
        @item_model = ItemModel.find(params[:id])
    end
    def new
        @item_model = ItemModel.new
    end
    def create
        @item_model = ItemModel.new(item_model_params)
        if @item_model.save
            return redirect_to @item_model, notice: 'Item criado com sucesso!'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o item'
            render :new, status: 422
        end
    end
    def edit
        @item_model = ItemModel.find(params[:id])
        if !@item_model.available?
            return redirect_to @item_model, notice: 'Item não pode mais ser editado'
        end
    end
    def update
        @item_model = ItemModel.find(params[:id])
        if !@item_model.available?
            return redirect_to @item_model, notice: 'Item não pode mais ser editado'
        elsif @item_model.update(item_model_params)
            return redirect_to @item_model, notice: 'Item atualizado com sucesso'
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
    def item_model_params
        params.require(:item_model).permit(
            :name,:description,:image,
            :weight,:length,:width,:depth,:category
        )
    end
end