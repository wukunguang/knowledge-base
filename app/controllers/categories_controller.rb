
class CategoriesController < ApplicationController

  before_action :auth, only: [:create, :delete]

  def index
    @categories = Category.where(user_id: current_user.id)
    render json: @categories, status: 200
  end

  def show
    @category = Category.find(params[:id])
    render json: @category
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(name: params[:name])
      render_msg(200)
    else
      render_msg(500)
    end
  end

  def create
    ww = params_cate
    ww[:user_id] = current_user.id
    Category.create(ww) ? render_msg(200) : render_msg(500)
  end

  def destroy
    Knowledge.destroy_all(category_id: params[:id])
    if Category.delete(params[:id])
      render_msg(200)
    else
      render_msg(404)
    end
  end

  private

  def params_cate
    params.permit(:name)
  end

  def auth
    render_msg(403) unless current_user
  end

end