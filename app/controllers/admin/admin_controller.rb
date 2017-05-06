
class Admin::AdminController < ApplicationController

  before_action do |controller|
    redirect_to '/' unless controller.send(:current_user)
  end
  

  layout 'admin'

  def index

    @user = current_user

  end

  def new

    @knowledge = KnowledgeRepository.new
    


  end

  def manage

    @_current_user

  end

  def users

  end






end