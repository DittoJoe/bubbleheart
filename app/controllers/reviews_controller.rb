class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @shop = Shop.find(params[:shop_id])
    @review.shop = @shop
  end

  def create
    @review = Review.new(review_params)
    @shop = Shop.find(params[:shop_id])
    @review.shop = @shop
    @review.user = current_user
    authorize @review
    @shop.set_rating
    @review.save
    redirect_to shop_path(@shop)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
