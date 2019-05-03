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
        
  
  
      elsif user.role? :baker


      elsif user.role? :shipper
      
        
      else
        # Guests can only read home page
    
      end
    end
  end