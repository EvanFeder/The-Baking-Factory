class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  before_action :check_login
  authorize_resource
  
  include AppHelpers::Cart

  def index
    if logged_in? && current_user.role?(:customer)
      @all_orders = current_user.customer.orders.chronological.paginate(:page => params[:page]).per_page(10)
    else
      @all_orders = Order.chronological.paginate(:page => params[:page]).per_page(10)
    end
  end

  def show
    @previous_orders = @order.customer.orders.chronological.to_a
  end

  def new
    @order = Order.new
    @cart = get_list_of_items_in_cart
    @subtotal = calculate_cart_items_cost
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.current
    @order.grand_total = calculate_cart_items_cost
    if logged_in? && current_user.role?(:customer)
      @order.customer_id = current_user.customer.id
    end

    if @order.save
      save_each_item_in_cart(@order)
      clear_cart
      @order.pay
      redirect_to @order, notice: "Thank you for ordering from the Baking Factory."
    else
      render action: 'new'
    end
  end
  

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address_id, :customer_id, :credit_card_number, :expiration_month, :expiration_year)
  end

end