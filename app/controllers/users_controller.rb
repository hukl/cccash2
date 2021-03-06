class UsersController < ApplicationController

  def index
    @admins = User.admins
    @angels = User.angels
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      # self.current_user = @user # !! now logged in
      redirect_to users_path
    else
      flash[:error]  = "We couldn't set up that account. Contact an admin"
      render :action => 'new'
    end
  end

  def show
    @user = User.find params[:id]
    @workshifts = @user.angel? ? @user.workshifts : @user.cleared_workshifts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    unless user.destroy
      messages = []
      user.errors.each_error { |field, error| messages << error.message }.join
      flash[:notice] = messages
    end

    redirect_to users_path
  end

end
