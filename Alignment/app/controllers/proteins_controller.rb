class ProteinsController < ApplicationController
  
  # GET /proteins
  # GET /proteins.json
  def index
    @proteins = Protein.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proteins }
    end
  end

  def generate_db
    Protein.delete_all
    Protein.generate_db(params[:soubor])
    redirect_to :action => 'index'
  end

end
