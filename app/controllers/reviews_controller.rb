class ReviewsController < ApplicationController
  before_action :set_order
  before_action :set_company
  before_action :check_client, only: %i[new create]

  def new
    if @order.review.present?
      flash[:alert] = t('.already_reviewed')
      redirect_to my_orders_path
      return
    end

    @review = Review.new
  end

  def create
    @review = @order.build_review(review_params)
    @review.company = @order.company
    if @review.save
      flash[:notice] = t('.success')
      redirect_to company_path(@company)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def set_company
    @company = @order.company
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def review_params
    params.require(:review).permit(:score, :text, photos: [])
  end

  def check_client
    return if @order.client == current_client

    flash[:alert] = t('.error')
    redirect_to my_orders_path
  end
end
