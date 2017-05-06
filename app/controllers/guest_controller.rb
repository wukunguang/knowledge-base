class GuestController < ApplicationController

  layout 'login', only: [:admin]

  def index

    @last_update = sort_by_update
    @getter_count = sort_by_count

  end


  def admin


  end

end