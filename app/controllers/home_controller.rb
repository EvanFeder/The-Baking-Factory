class HomeController < ApplicationController

  include AppHelpers::Baking
  include AppHelpers::Shipping

  def home
    if logged_in? && current_user.role?(:admin)

      @breads_bake = create_baking_list_for('bread')
      @muffins_bake = create_baking_list_for('muffins')
      @pastries_bake = create_baking_list_for('pastries')

      @unshipped = OrderItem.unshipped.paginate(:page => params[:page]).per_page(10)
      @shipped = OrderItem.shipped.paginate(:page => params[:page]).per_page(10)

    elsif logged_in? && current_user.role?(:customer)

    elsif logged_in? && current_user.role?(:baker)
      @breads = create_baking_list_for('bread')
      @muffins = create_baking_list_for('muffins')
      @pastries = create_baking_list_for('pastries')

    elsif logged_in? && current_user.role?(:shipper)
      @unshipped = OrderItem.unshipped.paginate(:page => params[:page]).per_page(10)
      @shipped = OrderItem.shipped.paginate(:page => params[:page]).per_page(10)



    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

  def search
    @query = params[:query]
    @customers = Customer.search(@query)
    @activeitems = Item.active.search(@query)
    @allitems = Item.search(@query)
  end


  def mark_shipped
    @item = OrderItem.find_by_id(params[:id])
    @item.shipped_on = Date.today
    @item.save!
    redirect_to home_path
  end

  def mark_unshipped
    @item = OrderItem.find_by_id(params[:id])
    @item.shipped_on = nil
    @item.save!
    redirect_to home_path
  end



end