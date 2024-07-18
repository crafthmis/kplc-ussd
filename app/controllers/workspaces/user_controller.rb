module Workspaces 
class UserController < ApplicationController
  before_action :set_user ,only: [:rolify ,:add_role ,:delete]
  before_action :check_user ,only: [:add_role,:manage,:rolify,:delete]

  layout "admin"

  def index
  end

  def new
    @user = User.new
  end

  def create
    database = params[:database].upcase

    @user = User.find_or_initialize_by(email: params[:user][:email])
    @user.username = params[:user][:username]
    @user.define_singleton_method(:password_required?) { false }

    respond_to do |format|
      if @user.save
         @user.invite!(current_user)
         format.html { redirect_to new_user_path}
      else
         format.html { render :new }
      end
    end
    
  end

  def manage
  end

  def rolify
  end

  def resend 
    organization = Organization.find(params[:organization_id])
    team = Team.find(params[:team_id])
    user = User.find(params[:id])
    if user.invite!(current_user)
      flash[:notice] = "Invitation was resend successfully."
    else
      flash[:notice] = "Invitation could not be resent."
    end
    redirect_to organization_team_path(organization,team)
  end

  def add_role 
    if User.with_role(:admin).count == 1 && @user == User.with_role(:admin).first && params[:role].downcase != "admin"
      flash[:notice] = "Forbidden! ,an admin user must exist."
    else
      @user.roles.delete_all 
      @user.add_role params[:role].downcase.to_sym
      flash[:notice] = "Role has been added."
    end
    redirect_to manage_user_index_path 
  end

   def delete
    if User.with_role(:admin).count == 1 && @user == User.with_role(:admin).first 
      flash[:notice] = "Forbidden! ,an admin user must exist."
    else
      @user.delete
      flash[:notice] = "#{@user.email} has been removed from this account." 
    end
      redirect_to manage_user_index_path 
  end


  private 
  def check_user 
    unless  current_user.has_role? :admin
      flash[:notice] = "Forbidden!, only admins can do that."
      redirect_to root_path
    end
  end

  def set_user 
    @user = User.find(params[:id])
  end
end
end























