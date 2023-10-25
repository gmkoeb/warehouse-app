class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update]
  before_action :warehouse_params, only: [:create, :update]
  
  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save()
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao cadastrar galpão.'
      render 'new'
    end
    
  end

  def edit;end

  def update
    if @warehouse.update(warehouse_params)
      @warehouse = Warehouse.update(slug: params[:warehouse][:name].parameterize)
      redirect_to warehouse_path(@warehouse.first.name.parameterize), notice: 'Galpão atualizado com sucesso! 😊'
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão. 😢'
      render 'edit' 
    end
  end

  private

  def set_warehouse
    @warehouse = Warehouse.friendly.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, 
                                      :description, :address, :cep, :area)
  end

end