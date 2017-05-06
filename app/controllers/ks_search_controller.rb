class KsSearchController < ApplicationController

  def index
    re = Elasticsearch::Persistence::Repository.new
    ks = KnowledgeSearch.new
    @keywords = params[:keyword]
    #设置默认起始页数
    @current_page = 1
    @count = re.count(ks.build_dsl(@keywords))
    if (@count%RESULT_PER_PAGE > 0) then
      @all_page = @count/RESULT_PER_PAGE + 1
    else
      @all_page = @count/RESULT_PER_PAGE
    end
    if is_number?(params[:page]) && params[:page]
      p_page = params[:page].to_i
      if p_page < 0
        @current_page = 1
      elsif p_page >= 1 && p_page <= @all_page
        @current_page = p_page
      else
        @current_page = @all_page
      end
    else
      @current_page = 1
    end
    @result = re.search(ks.build_dsl(@keywords, size = RESULT_PER_PAGE, from = (@current_page - 1) * RESULT_PER_PAGE ))
    puts @current_page
  end

end