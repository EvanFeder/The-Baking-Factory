class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource
  
    def index
      # finding all the active owners and paginating that list (will_paginate)
      @users = User.all.paginate(page: params[:page]).per_page(10)
    end
  
    def new
      @user = User.new
    end
  
    def edit
      #@user.role = "assistant" if current_user.role?(:assistant)
    end
  
    def create
      @user = User.new(user_params)
      #@user.role = "assistant" if current_user.role?(:assistant)
      if @user.save
        session[:user_id] = @user.id
        redirect_to users_url, notice: "Successfully added #{@user.username} as a user." # where to redirect?
      else
        render action: 'new'
      end
    end
  
    def update
      if @user.update_attributes(user_params)
        redirect_to users_url, notice: "Successfully updated #{@user.username}."
      else
        render action: 'edit'
      end
    end
    

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:active, :username, :role, :password, :password_confirmation)
    end
  
end