class ShopsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @shops = policy_scope(Shop)
    @shops = Shop.all
    @shops.each do |shop|
      shop.set_rating
    end
    @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        info_window: render_to_string(partial: "info_window", locals: { shop: shop })
      }
    end
    if params[:query].present?
      @shops = @shops.search_by_name_and_details(params[:query])
      @shops.each do |p|
        p.set_rating
      end
      @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        info_window: render_to_string(partial: "info_window", locals: { shop: shop })
      }
      end
      @shops = @shops.sort_by(&:rating).reverse
    else
      @shops = @shops.sort_by(&:rating).reverse
    end
  end

  def show
    @review = Review.new
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews
    @shop_arr = []
    @shop_arr << @shop
    @markers = @shop_arr.map do |shop|
      {
        lat: shop.latitude.nil? ? 59.3354662 : shop.latitude,
        lng: shop.longitude.nil? ? 18.0600026 : shop.longitude,
        info_window: render_to_string(partial: "info_window", locals: { shop: shop })
      }
    end
    @favorite = is_favorite?(@shop.id)
    @shop.set_rating
    @user = current_user
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render :new
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.update(shop_params)
    redirect_to shop_path(@shop)
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :address, :region, :details, photos: [])
  end

  def is_favorite?(id)
    @user = current_user
    @bookmark = @user.bookmarks.where(:shop_id => id).last
    return @bookmark.present?
  end
end
