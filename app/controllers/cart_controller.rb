class CartController < ApplicationController
    before_action :check_login

    include AppHelpers::Cart
    
    def index
      @current_cart = get_list_of_items_in_cart
      @subtotal = calculate_cart_items_cost
    end
  
    def add_to_cart
      add_item_to_cart(params[:id])
      redirect_to cart_path, notice: "Added to cart!"
    end
  
    def remove_from_cart
      remove_item_from_cart(params[:id])
      redirect_to cart_path, notice: "Removed from cart!"
    end

    def clear
      clear_cart
      redirect_to cart_path, notice: "Cart cleared!"
    end
 
  
  end