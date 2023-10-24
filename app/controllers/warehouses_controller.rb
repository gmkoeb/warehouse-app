class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.friendly.find(params[:id])
  end

  def new
    @new_warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, 
                                                        :description, :address, :cep, :area )
                                                        # Strong parameters

    @new_warehouse = Warehouse.new(warehouse_params)

    if @new_warehouse.save()
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao cadastrar galpão.'
      render 'new'
    end
    
  end

  def edit
    @warehouse_to_edit = Warehouse.friendly.find(params[:id])
  end

  def update
    @warehouse_to_edit = Warehouse.friendly.find(params[:id])

    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, 
    :description, :address, :cep, :area)

    if @warehouse_to_edit.update(warehouse_params)
      @warehouse_to_edit = Warehouse.update(slug: params[:warehouse][:name].parameterize)
      redirect_to warehouse_path(@warehouse_to_edit.first.name.parameterize), notice: 'Galpão atualizado com sucesso! 😊'
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão. 😢'
      render 'edit' 
    end
  end

end