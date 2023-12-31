class ProductModelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @product_models = ProductModel.all
  end

  def show
    @product_model = ProductModel.friendly.find(params[:id])
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end
  
  def create
    @product_model = ProductModel.new
    product_models_params = params.require(:product_model).permit(:name, :height, :width, :depth, :weight,
                                                                  :sku, :supplier_id)
    @product_model = ProductModel.new(product_models_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto.'
      render 'new'
    end
  end
end