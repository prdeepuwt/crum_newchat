class TimeTablesController < ApplicationController
  before_action :set_time_table, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /time_tables
  # GET /time_tables.json
  def index
    authorize TimeTable
    if(params[:user_id])
      @time_tables = User.find(params[:user_id]).time_tables.where({:privacy=>'open'})
    else
      @time_tables = current_user.time_tables
    end
  end

  # GET /time_tables/1
  # GET /time_tables/1.json
  def show
  end

  # GET /time_tables/new
  def new
    @time_table = TimeTable.new
    authorize @time_table
  end

  # GET /time_tables/1/edit
  def edit
  end

  # POST /time_tables
  # POST /time_tables.json
  def create
    @time_table = TimeTable.new(time_table_params)
    @time_table.user = current_user
    authorize @time_table
    respond_to do |format|
      if @time_table.save
        format.html { redirect_to @time_table, notice: 'Time table was successfully created.' }
        format.json { render :show, status: :created, location: @time_table }
      else
        format.html { render :new }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_tables/1
  # PATCH/PUT /time_tables/1.json
  def update
    respond_to do |format|
      if @time_table.update(time_table_params)
        format.html { redirect_to @time_table, notice: 'Time table was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_table }
      else
        format.html { render :edit }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_tables/1
  # DELETE /time_tables/1.json
  def destroy
    @time_table.destroy
    respond_to do |format|
      format.html { redirect_to time_tables_url, notice: 'Time table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_table
      @time_table = TimeTable.find(params[:id])
      authorize @time_table
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_table_params
      params.require(:time_table).permit(:title, :description, :start, :end, :privacy, :user_id)
    end
end
