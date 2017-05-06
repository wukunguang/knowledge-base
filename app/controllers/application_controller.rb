class ApplicationController < ActionController::Base

  RESULT_PER_PAGE = 10
  include RedisSetter
  protect_from_forgery with: :exception

  around_action :error_raise


  def login_auth
    unless current_user
      session.destroy
      redirect_to '/'
    end
  end

  private

  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  # @param [Object] code
  def render_msg(code, msg = nil)
    case code
      when 403
        render json: {msg: 'Forbidden', reason: msg}, status: code
      when 404
        render json: {msg: 'Not Found', reason: msg}, status: code
      when 422
        render json: {msg: 'Unprocessable Entity', reason: msg}, status: code
      when 400
        render json: {msg: 'Bad Request', reason: msg}, status: code
      when 200
        render json: {msg: 'OK!'}, status: code
      else
        render json: { msg: 'Unknow Error', reason: msg }, status: code
    end

  end

  #正则表达式，判定传入restful的id参数是否为数字。
  def is_number?(id)
    !(id =~ /\D/)
  end

  #用于控制器方法异常处理。

  def error_raise
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      render_msg 404
    else

    end

  end

end
