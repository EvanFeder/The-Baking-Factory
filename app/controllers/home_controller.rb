class HomeController < ApplicationController

  include AppHelpers::Baking
  include AppHelpers::Shipping

  def home
    if logged_in? && current_user.role?(:admin)

    elsif logged_in? && current_user.role?(:customer)

    elsif logged_in? && current_user.role?(:baker)
      # @breads = OrderItem.shipped.select{|o| o.item.category == "bread"}
      # @muffins = OrderItem.unshipped.select{|o| o.item.category == "muffins"}
      # @pastries = OrderItem.unshipped.select{|o| o.item.category == "pastries"}

      # @breads_hash = Hash.new(0)
      # @muffins_hash = Hash.new(0)
      # @pastries_hash = Hash.new(0)
      
      # @breads.each { |good| @breads_hash[good] += good.quantity }
      # @muffins.each { |good| @muffins_hash[good] += good.quantity }
      # @pastries.each { |good| @pastries_hash[good] += good.quantity }

      @breads = create_baking_list_for('bread')
      @muffins = create_baking_list_for('muffins')
      @pastries = create_baking_list_for('pastries')


    elsif logged_in? && current_user.role?(:shipper)

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



end