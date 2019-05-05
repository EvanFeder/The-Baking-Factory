class ItemPricesController < ApplicationController
    before_action :check_login
    authorize_resource
  
    def show
      @previous_prices = @item_price.item.item_prices.chronological.to_a
    end
  
    def new
      @item_price = ItemPrice.new
      @item = Item.find(params[:item_id])
    end
  
    def edit
    end
  
    def create
      @item_price = ItemPrice.new(item_price_params)
      @item_price.start_date = Date.current
      @item = Item.find(params[:item_price][:item_id])
      
      if @item_price.save
        redirect_to item_path(@item), notice: "The item's price has been added."
      else
        render action: 'new', locals: { item: @item }
      end
    end
  

  
    private
    def item_price_params
      params.require(:item_price).permit(:item_id, :price)
    end
  
  end