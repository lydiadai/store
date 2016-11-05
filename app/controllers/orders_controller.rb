class OrdersController < ApplicationController
    before_action :authenticate_user!

    def create
        @order = Order.new(order_params)
        @order.user = current_user
        @order.total = current_cart.total_price
        if @order.save
            current_cart.cart_items.each do |cart_item|
                product_list = ProductList.new
                product_list.order = @order
                product_list.product_name = cart_item.product.title
                product_list.product_price = cart_item.product.price
                product_list.quantity = cart_item.quantity
                product_list.save
            end
            redirect_to order_path(@order.token)
        else
            render 'carts/checkout'
        end
    end

    def show
        @order = Order.find_by_token(params[:id])
        @product_lists = @order.product_lists
    end

    def pay_with_wechat
        @order = Order.find_by_token(params[:id])
        @order.is_paid = true
        @order.save
        @order.payment_method = 'wechat'
        @order.make_payment!
        flash[:notice] = '已付款'
        redirect_to :back
    end

    def pay_with_alipay
        @order = Order.find_by_token(params[:id])
        @order.is_paid = true
        @order.payment_method = 'alipay'
        @order.make_payment!
        @order.save
        flash[:notice] = '已付款'
        redirect_to :back
    end

    def cancell
        @order = Order.find(params[:id])
        @order.is_cancell = false
        @order.save
        OrderMailer.notify_order_cancelled(Order.last).deliver!
    end

    def cancelled
        @order = Order.find(params[:id])
        @order.is_cancell = true
        @order.save
        OrderMailer.notify_order_cancelled(Order.last).deliver!
    end

    def ship
        @order = Order.find(params[:id])
        @order.ship!
        redirect_to :back
        OrderMailer.notify_order_ship(Order.last).deliver!
    end

    private

    def order_params
        params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
    end
end
