class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :find_plan, only: %i[destroy show]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      if @category.name == "Cultural"
        @plans = Plan.where(category_id: @category.id)
      elsif @category.name == "Ecologico"
        @plans = Plan.where(category_id: @category.id)
      elsif @category.name == "Gastronomico"
        @plans = Plan.where(category_id: @category.id)
      elsif @category.name == "Party"
        @plans = Plan.where(category_id: @category.id)
      end
    elsif params[:user_id]
      @plans = Plan.where(user_id: params[:user_id])
    else
      @plans = Plan.all
    end
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      redirect_to plan_path(@plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
    redirect_to list_path(@plan.list), status: :see_other
  end

  private

  def find_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:category_id, :title, :video_url, :details, :start_date)
  end
end
