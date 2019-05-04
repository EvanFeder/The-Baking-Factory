class ItemPricesController < ApplicationController
    before_action :set_item_price, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource
    
    def index
      @item_prices = ItemPrice.chronological.paginate(:page => params[:page]).per_page(10)
    end
  
    def show
    end
  
    def new
      @item_price = ItemPrice.new
    end
  
    def edit
    end
  
    def create
      @item_price = ItemPrice.new(item_price_params)
      
      if @item_price.save
        redirect_to items_path(@item_price.item), notice: "The item's price has been added."
      else
        render action: 'new'
      end
    end
  
    def update # can these be edited??
      if @item_price.update(item_price_params)
        redirect_to items_path(@item_price.item), notice: "The item price was revised in the system." # idk?
      else
        render action: 'edit'
      end
    end
  
    private
    def set_item_price
      @item_price = ItemPrice.find(params[:id])
    end
  
    def item_price_params
      params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
    end
  
  end