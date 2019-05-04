class OrderItemsController < ApplicationController
    before_action :set_order_item, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    
    def index
      @all_order_items = OrderItem.all.paginate(:page => params[:page]).per_page(10)
      @shipped_order_items = OrderItem.shipped.paginate(:page => params[:page]).per_page(10)
      @unshipped_order_items = OrderItem.unshipped.paginate(:page => params[:page]).per_page(10)
    end
  
    def show
    end
  
    def new
      @order_item = OrderItem.new
    end
  
    def edit
    end
  
    def create
      @order_item = OrderItem.new(order_item_params)
      
      if @order_item.save
        redirect_to items_path, notice: "The item was added to yout cart." # redirect to same page, or cart?
      else
        render action: 'new'
      end
    end
  
    def update
      if @order_item.update(order_item_params)
        redirect_to items_path, notice: "The order item was revised in the system." # should go to cart?
      else
        render action: 'edit'
      end
    end
  
  
    private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
  
    def order_item_params
      params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
    end
  
  end