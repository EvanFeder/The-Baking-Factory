class CartsController < ApplicationController
    before_action :set_cart, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    include AppHelpers::Cart
    
    def index
      
    end
  
    def show
    end
  
    def new
      create_cart
    end
  
    def edit
    end
  
    def create
      
    end
  
    def update
      
    end
  
  
    private
    def set_cart
      
    end
  
    def cart_params
      
    end
  
  end