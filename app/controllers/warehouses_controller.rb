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
end