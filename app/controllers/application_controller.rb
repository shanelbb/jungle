class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  helper_method :cart, :enhanced_cart, :cart_subtotal_cents, :current_user, :logged_in?

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map do |product|
      { product: product, quantity: cart[product.id.to_s] }
    end
  end

  def cart_subtotal_cents
    enhanced_cart.map { |entry| entry[:product].price_cents * entry[:quantity] }.sum
  end

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
