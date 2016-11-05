module ProductsHelper
    def render_product_status(product)
        if product.is_hidden
            link_to(content_tag(:span, '', class: 'fa fa-lock'), publish_admin_product_path(product), method: :post, class: 'btn btn-xs')

        else
            link_to(content_tag(:span, '', class: 'fa fa-level-down'), hide_admin_product_path(product), method: :post, class: 'btn btn-xs')
        end
    end
end
