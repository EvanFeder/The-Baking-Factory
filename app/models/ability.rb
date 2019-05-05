class Ability
    include CanCan::Ability
  
    def initialize(user)
      # set user to new User if not logged in
      user ||= User.new # i.e., a guest user
      
      # set authorizations for different user roles
      if user.role? :admin
        # they get to do it all
        can :manage, :all
        
      elsif user.role? :customer
        can :read, Item
        can :show, Item

        can :index, Order
        can :create, Order
        can :checkout, Order
        can :add_to_cart, Order

        can :show, Customer do |this_customer|  
            user.customer == this_customer
        end

        can :update, Customer do |this_customer|  
            user.customer == this_customer
        end

        can :show, User do |u|  
            u.id == user.id
        end

        can :update, User do |u|  
            u.id == user.id
        end

        can :show, Order do |this_order|  
            my_orders = user.customer.orders.map(&:id)
            my_orders.include? this_order.id 
        end

        can :manage, Address do |this_address|  
            my_addresses = user.customer.addresses.map(&:id)
            my_addresses.include? this_address.id 
        end

      elsif user.role? :baker
        can :index, Item
        can :show, Item
        can :index, Order

      elsif user.role? :shipper
        can :index, Item
        can :show, Item
        can :index, Order
        can :show, Order
        can :index, Address
        can :show, Address
        
      else
        # Guests can only read home page and items and become users
        can :index, Item
        can :show, Item
        can :create, Customer
        can :create, User # maybe not
    
      end
    end
  end