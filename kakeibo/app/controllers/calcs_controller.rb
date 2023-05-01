class CalcsController < ApplicationController
  before_action :set_calc, only: %i[ show edit update destroy ]
  before_action :login_seigen
  before_action :kengen_check, only: %i[ show edit update destroy ]
  before_action :zero_delete, only: %i[ index ]

  # GET /calcs or /calcs.json
  def index
    @calcs = Calc.where(user_id: @current_user.id).order(hizuke: :asc, food: :asc)
    $a_month = "全データ"
  end

  # GET /calcs/1 or /calcs/1.json
  def show
    render layout: "s_layout"
  end

  # GET /calcs/new
  def new
    @calc = Calc.new
  end

  def squeeze
    @calcs = Calc.where(user_id: @current_user.id).order(hizuke: :asc, food: :asc)
    @wat = @calcs.map{|t| t.hizuke}
    @wat = @wat.group_by(&:itself).map{|key, value| [key, value.count]}.to_h
    @wat = @wat.select{|key, value| value > 1}.keys
    @wat.each do |wat|
      @ramdas = Calc.where(hizuke: wat)
      $d_food = 0
      $d_daily = 0
      $d_housing = 0
      $d_traffic = 0
      $d_recreation = 0
      $d_others = 0
      @ramdas.each do |r|
        $d_food += r.food
        $d_daily += r.daily
        $d_housing += r.housing
        $d_traffic += r.traffic
        $d_recreation += r.recreation
        $d_others += r.others
      end
      @ramdas.each do |r|
        r.destroy
      end
      my_data = Calc.new(hizuke: wat, food: $d_food, daily: $d_daily, housing: $d_housing, traffic: $d_traffic, recreation: $d_recreation, others: $d_others, user_id: @current_user.id)
      my_data.save
    end
    redirect_to '/calcs'
  end

  # GET /calcs/1/edit
  def edit
    render layout: "e_layout"
  end

  # POST /calcs or /calcs.json
  def create
    has = calc_params
    has[:food] = eval(has[:food]).to_i
    has[:daily] = eval(has[:daily]).to_i
    has[:housing] = eval(has[:housing]).to_i
    has[:traffic] = eval(has[:traffic]).to_i
    has[:recreation] = eval(has[:recreation]).to_i
    has[:others] = eval(has[:others]).to_i
    has[:user_id] = @current_user.id
    @calc = Calc.new(has)

    respond_to do |format|
      if @calc.save
        format.html { redirect_to calc_url(@calc), notice: "登録に成功しました" }
        format.json { render :show, status: :created, location: @calc }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calcs/1 or /calcs/1.json
  def update
    has = calc_params
    has[:food] = eval(has[:food])
    has[:daily] = eval(has[:daily])
    has[:housing] = eval(has[:housing])
    has[:traffic] = eval(has[:traffic])
    has[:recreation] = eval(has[:recreation])
    has[:others] = eval(has[:others])
    respond_to do |format|
      if @calc.update(has)
        format.html { redirect_to calc_url(@calc), notice: "編集に成功しました" }
        format.json { render :show, status: :ok, location: @calc }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calcs/1 or /calcs/1.json
  def destroy
    @calc.destroy

    respond_to do |format|
      format.html { redirect_to calcs_url, notice: "削除に成功しました" }
      format.json { head :no_content }
    end
  end

  def select
    $a_month = params[:method]
    @calcs = Calc.where(user_id: @current_user.id).order(hizuke: :asc, food: :asc)
    @calcs = @calcs.find_all{|c| c.hizuke.month == $a_month.slice(/\d{2}月/).delete('月').to_i}
    #@calcs = @calcs.where('extract(year from hizuke) = ? AND extract(month from hizuke) = ?', Time.now.year, $a_month.slice(/\d{2}月/).delete('月').to_i)
    render '/calcs/index'
  end

  def graph
    @ym = params[:id]
    @calcs = Calc.where(user_id: @current_user.id).order(hizuke: :asc, food: :asc).where("hizuke like ?", "#{@ym}%")
    @start = Date.parse("#{@ym}-01")
    @end = Date.new(@start.year, @start.month, -1)
    (@start..@end).each do |date|
      unless @calcs.find{|a| a.hizuke == date}
        Calc.new(hizuke: date.to_s, user_id: @current_user.id, food:0, daily:0, housing:0, traffic:0, recreation:0, others:0).save
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def zero_delete
      @calcs = Calc.where(user_id: @current_user.id).order(hizuke: :asc, food: :asc)
      @calcs.each do |calc|
        if calc.food + calc.daily + calc.housing + calc.traffic + calc.recreation + calc.others == 0
          calc.destroy
        end
      end
    end

    def set_calc
      @calc = Calc.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calc_params
      params.require(:calc).permit(:hizuke, :food, :daily, :housing, :traffic, :recreation, :others)
    end

    def kengen_check
      if @calc.user_id != @current_user.id
        redirect_to('/calcs', notice: '権限がありません')
      end
    end
end
