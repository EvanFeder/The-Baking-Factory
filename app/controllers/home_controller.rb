class HomeController < ApplicationController

  def home
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