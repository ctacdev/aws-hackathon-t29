class HistoricalCapsController < ApplicationController
  before_action :set_historical_cap, only: [:show, :edit, :update, :destroy]

  # GET /historical_caps
  # GET /historical_caps.json
  def index
    @historical_caps = HistoricalCap.all
  end

  # GET /historical_caps/1
  # GET /historical_caps/1.json
  def show
    respond_to do |format|
      format.html {}
      format.xml { render xml: @historical_cap.data }
    end
  end

  # GET /historical_caps/new
  def new
    @historical_cap = HistoricalCap.new
  end

  # GET /historical_caps/1/edit
  def edit
  end

  # POST /historical_caps
  # POST /historical_caps.json
  def create
    @historical_cap = HistoricalCap.new(historical_cap_params)

    respond_to do |format|
      if @historical_cap.save
        format.html { redirect_to @historical_cap, notice: 'Historical cap was successfully created.' }
        format.json { render :show, status: :created, location: @historical_cap }
      else
        format.html { render :new }
        format.json { render json: @historical_cap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_caps/1
  # PATCH/PUT /historical_caps/1.json
  def update
    respond_to do |format|
      if @historical_cap.update(historical_cap_params)
        format.html { redirect_to @historical_cap, notice: 'Historical cap was successfully updated.' }
        format.json { render :show, status: :ok, location: @historical_cap }
      else
        format.html { render :edit }
        format.json { render json: @historical_cap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_caps/1
  # DELETE /historical_caps/1.json
  def destroy
    @historical_cap.destroy
    respond_to do |format|
      format.html { redirect_to historical_caps_url, notice: 'Historical cap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historical_cap
      @historical_cap = HistoricalCap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historical_cap_params
      params.require(:historical_cap).permit(:user_id, :data)
    end
end
