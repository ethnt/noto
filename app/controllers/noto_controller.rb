class NotoController < ApplicationController
  layout 'page'

  def index
    if current_user
      render 'notes/index', layout: 'application'
    else

    end
  end

  def about
  end

  def ui
    render 'noto/ui', layout: 'application'
  end
end
