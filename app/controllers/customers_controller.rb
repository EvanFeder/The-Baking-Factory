class CustomersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :check_login, except: [:new, :create]
  authorize_resource
  
  def index
    @active_customers = Customer.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_customers = Customer.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @previous_orders = @customer.orders.chronological
  end

  def new
    @customer = Customer.new
    @customer.build_user
  end

  def edit
    # reformat phone w/ dashes when displayed for editing (preference; not required)
    @customer.phone = number_to_phone(@customer.phone)
    # should have a user associated with customer, but just in case...
    #user = (@customer.user.nil? ? @customer.build_user : @customer.user)
  end

  def create
    byebug

    #convert users to user_attributes in the params
    temp_params = customer_params
    user_attributes = temp_params[:users]
    user_attributes[:role] = "Customer"
    user_attributes[:active] = true
    temp_params[:user_attributes] = user_attributes
    temp_params.delete(:users)

    
    @customer = Customer.new(temp_params)
    

    #@customer.user_id = @user.id

    if @customer.save
      redirect_to @customer, notice: "#{@customer.proper_name} was added to the system."
      sessions[:user_id] = @customer.user_id
    else
      render action: 'new'
    end

  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "#{@customer.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end


  private
  def convert_user_role
    unless current_user && current_user.role?(:admin)
      # if you aren't admin, we are overriding the role param to be customer
      params[:customer][:user_attributes][:role] = "Customer" # is this the correct way? TODO
    end
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    #convert_user_role
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, user_attributes: [:username, :password, :password_confirmation])
  end

  # def user_params
  #   params.require(:customer).permit(:username, :password, :password_confirmation, :role, :active)
  # end



end