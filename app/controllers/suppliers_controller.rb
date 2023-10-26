class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.friendly.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    suppliers_params = params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, 
                                                        :full_address, :city, :state, :email)           
    @supplier = Supplier.new(suppliers_params)

    if @supplier.save()
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso! 😊'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o fornecedor'
      render 'new'
    end
  end
end