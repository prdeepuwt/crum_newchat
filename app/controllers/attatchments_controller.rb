class AttatchmentsController < ApplicationController
  before_action :set_attatchment, only: [:show, :destroy]
  def index
    @attatchments = Attatchment.all
  end
  def show
  end

  # GET /posts/new
  def new
    @attatchment = Attatchment.new
  end

  def create
    @attatchment = Attatchment.new(attatchment_params)
    respond_to do |format|
      if @attatchment.save
        format.html { render :new, notice: 'Attatchment was successfully created.' }
        format.json { render :show, status: :created, location: @attatchment }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @attatchment.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @attatchment.destroy
    respond_to do |format|
      format.html { redirect_to attatchment_url, notice: 'Attatchment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attatchment
      @attatchment = Attatchment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attatchment_params
      params.require(:attatchment).permit(:comment, :file, :message_id)
    end
end
