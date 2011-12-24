class SpecialGuestsController < ApplicationController

  skip_before_filter :admin_status_required

  def index
    @special_guests = SpecialGuest.paginate :page => params[:page]
  end

  def new
    @special_guest  = SpecialGuest.new params[:special_guest]
  end

  def create
    @special_guest = SpecialGuest.new params[:special_guest]
    @special_guest.assign_ticket params[:ticket]

    if @special_guest.save
      redirect_to special_guests_path
    else
      render :new
    end

  end

  def show
    @special_guest = SpecialGuest.find(params[:id])
    if !@special_guest.checked_in then
      @cart = ( session[:cart] ||= Cart.new )
      @cart.reset
      session[:valid] = true
    else
      flash[:notice] = "This guest already checked in!"
      redirect_to cart_path
    end
  end

  def edit
    @special_guest = SpecialGuest.find(params[:id])
  end

  def update
    @special_guest = SpecialGuest.find(params[:id])

    if @special_guest.update_attributes( params[:special_guest] )
      redirect_to special_guests_path
    else
      render :edit
    end
  end

  def destroy
    special_guest = SpecialGuest.find(params[:id])
    special_guest.destroy unless special_guest.nil?
    redirect_to special_guests_path
  end

  def search
    unless params[:search_term].blank?
      @search_results = SpecialGuest.search params[:search_term]
    else
      @search_results = []
    end

    @results = SpecialGuest.find( @search_results.to_a.map(&:id) )

    render :partial => 'search_results'
  end

  def admin_search
    unless params[:search_term].blank?
      @search_results = SpecialGuest.search params[:search_term]
    else
      @search_results = SpecialGuest.paginate :page => params[:page]
    end

    @special_guests = SpecialGuest.find( @search_results.to_a.map(&:id) )

    render :partial => @special_guests
  end

end
