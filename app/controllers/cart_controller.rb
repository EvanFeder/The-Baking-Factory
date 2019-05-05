class CartController < ApplicationController
    before_action :set_address, only: [:show, :edit, :update, :destroy]
    before_action :check_login

    include AppHelpers::Cart
    
    def index
      @current_cart = get_list_of_items_in_cart
      @subtotal = calculate_cart_items_cost
    end
  
    def add_to_cart
        add_item_to_cart(params[:id])
        redirect_to cart_path
    end
  
    def remove_from_cart
        remove_item_from_cart(params[:id])
        redirect_to cart_path
    end
 
  
  end