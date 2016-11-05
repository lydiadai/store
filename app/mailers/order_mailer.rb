class OrderMailer < ApplicationMailer
    def notify_order_placed(order)
        @order = order
        @user = order.user
        @product_lists = @order.product_lists
        mail(to: @user.email, subject: '[JDstore]感谢您完成本次购物，以下是您的购物明细 ＃{order.token}')
    end

    def notify_order_cancelled(order)
        @order = order
        @user = order.user
        @product_lists = @order.product_lists
        mail(to: @user.email, subject: '[JDstore]你已取消订单 ＃{order.token}')
    end

    def notify_order_ship(order)
        @order = order
        @user = order.user
        @product_lists = @order.product_lists
        mail(to: @user.email, subject: '[JDstore]你的订单已出货 ＃{order.token}')
    end
end
