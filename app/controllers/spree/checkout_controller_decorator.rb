Spree::CheckoutController.class_eval do
  helper 'spree/products'
  Spree::PermittedAttributes.line_item_attributes << {add_on_ids: []}
end
