require 'rubygems'
require 'google_chart'

class FoodTracksController < ApplicationController
  # GET /food_tracks
  # GET /food_tracks.json
  def index
    @ft_date = 1.days.ago
    #@ft_date = 3.days.ago
    @food_tracks = FoodTrack.all(:conditions => ["date >= ?", @ft_date], :order => "date(date) desc, date asc")

    unless @food_tracks.empty? 
      @food_tracks_total = @food_tracks.to_a.sum {|ft| ft.food.kkal/100*ft.weight}
      @ft_total_weight = @food_tracks.to_a.sum {|ft| ft.weight}
      @ft_total_protein = @food_tracks.to_a.sum {|ft| ft.food.protein/100*ft.weight}
      @ft_total_carb = @food_tracks.to_a.sum {|ft| ft.food.carb/100*ft.weight}
      @ft_total_fat = @food_tracks.to_a.sum {|ft| ft.food.fat/100*ft.weight}

      @ft_p_part = @ft_total_protein*4/@food_tracks_total
      @ft_f_part = @ft_total_fat*9/@food_tracks_total
      @ft_c_part = @ft_total_carb*4/@food_tracks_total

      GoogleChart::PieChart.new('400x200', "",false) do |pc| 
        pc.data "Fat #{"%.1f\%" % (@ft_f_part*100)}", @ft_total_fat
        pc.data "Proteins #{"%.1f\%" % (@ft_p_part*100)}", @ft_total_protein
        pc.data "Carbs #{"%.1f\%" % (@ft_c_part*100)}", @ft_total_carb
        @chart_img=pc.to_url 
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_tracks }
    end
  end
  
  # GET /food_tracks/1
  # GET /food_tracks/1.json
  def show
    @food_track = FoodTrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food_track }
    end
  end

  # GET /food_tracks/new
  # GET /food_tracks/new.json
  def new
    @food_track = FoodTrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food_track }
    end
  end

  # GET /food_tracks/1/edit
  def edit
    @food_track = FoodTrack.find(params[:id])
  end

  # POST /food_tracks
  # POST /food_tracks.json
  def create
    fn = params[:food_track].delete('food_name')
    if fn
      food = Food.find_by_name(fn)
      params[:food_track][:food_id]=food.id
    end

    ftime = params[:food_track].delete('date')
    if ftime
      begin
        if ftime.length==4 
          h=Integer(ftime[0,2])
          m=Integer(ftime[2,2])
        else
          h=Integer(ftime[/0*(\d*)\:0*(\d*)/, 1])
          m=Integer(ftime[/0*(\d*)\:0*(\d*)/, 2])
        end
        # params[:food_track][:date] = Date.today + h.hours + m.minutes
        params[:food_track][:date] = 1.days.ago.to_date + h.hours + m.minutes
      rescue
        params[:food_track][:date] = Time.now
      end
    end

    @food_track = FoodTrack.new(params[:food_track])

    respond_to do |format|
      if @food_track.save
        format.html { redirect_to food_tracks_url, notice: 'Food track was successfully created.' }
        format.json { render json: @food_track, status: :created, location: @food_track }
      else
        format.html { render action: "new" }
        format.json { render json: @food_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /food_tracks/1
  # PUT /food_tracks/1.json
  def update
    @food_track = FoodTrack.find(params[:id])

    respond_to do |format|
      if @food_track.update_attributes(params[:food_track])
        format.html { redirect_to @food_track, notice: 'Food track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_tracks/1
  # DELETE /food_tracks/1.json
  def destroy
    @food_track = FoodTrack.find(params[:id])
    @food_track.destroy

    respond_to do |format|
      format.html { redirect_to food_tracks_url }
      format.json { head :no_content }
    end
  end
end
