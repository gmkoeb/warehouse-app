class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @products = @order.supplier.product_models
  end

  def create
    @order = Order.find(params[:order_id])
    order_items_params = params.require(:order_item).permit(:product_model_id, :quantity)

    @order_item = @order.order_items.build(order_items_params)

    @order_item.save

    redirect_to @order, notice: 'Item adicionado com sucesso.'
  end
end