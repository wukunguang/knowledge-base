class KsController < ApplicationController

  layout 'admin', only: [:new, :edit]


  def show
    c_id = params[:id]
    @ks_res = Knowledge.find c_id
    re = Elasticsearch::Persistence::Repository.new
    tmp = re.find(params[:id]).to_hash
    update_get_count c_id
    @ks_res.tag_name = tmp['tag_name']
    @last_update = sort_by_update
    @getter_count = sort_by_count
  end

  def index
    c_id = params[:category_id]
    ss = Category.find(c_id)
    render json: ss.knowledge
  end

  def destroy
    c_id = params[:id]
    if Knowledge.delete(c_id)
      render_msg 200
    else
      render_msg 500
    end
  end

  def create
    @ks = Knowledge.new
    @ks.category_id = params[:category_id]
    @ks.content = ks_params[:content]
    @ks.title = ks_params[:title]
    @ks.tag_name = ks_params[:tag_name]
    @ks.author = current_user.username
    @ks.user_id = current_user.id
    if @ks.save!
      redirect_to '/admin/manage'
    else
      render_msg 500
    end
  end

  def new

  end

  def edit
    @ks = Knowledge.find(params[:id])
    re = Elasticsearch::Persistence::Repository.new
    tmp = re.find(params[:id]).to_hash
    @ks.tag_name = tmp['tag_name']
  end

  def update
    if Knowledge.update(ks_params[:id], ks_params)
      redirect_to '/admin/manage'
    else
      redirect_back
    end
  end


  def search

  end

  private

  def ks_params

    params.permit(:title, :content, :category_id, :id, :tag_name)

  end

end
