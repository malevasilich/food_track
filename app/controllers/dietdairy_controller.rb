# encoding: utf-8
require "open-uri"

class DietdairyController < ApplicationController

  def get_dd_entry(str)
      return [] if str.nil? || str.empty?

         dietdairy_url = "http://dietadiary.com/meal/food/json?sEcho=2&iColumns=7&sColumns=&iDisplayStart=0&iDisplayLength=50&sNames=%2C%2C%2C%2C%2C%2C&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=true&sSearch_4=&bRegex_4=false&bSearchable_4=true&sSearch_5=&bRegex_5=false&bSearchable_5=true&sSearch_6=&bRegex_6=false&bSearchable_6=true&iSortingCols=1&iSortCol_0=1&sSortDir_0=asc&bSortable_0=true&bSortable_1=true&bSortable_2=true&bSortable_3=true&bSortable_4=true&bSortable_5=true&bSortable_6=true&main=1&_=1361418562484"
         proxy = {:proxy_http_basic_authentication => %w(HTTP://border.kkb.kz:80 AArzamasov QWEasdzxc00)}

         dd_cache = Rails.cache.read('dd_cache')
         if dd_cache.nil?
            Rails.cache.write('dd_cache', {})
            dd_cache = {}
          end
        if dd_cache && dd_cache[str] then
            dd_cache[str]
        else
          puts 'Getting from dietadiary.com...'
          j = open(dietdairy_url+"&sSearch="+URI.escape(str), proxy).read
          puts j
          r=JSON.parse(j)
          
          res = []
          # try only the items that starts with the search string from the main db
          r['aaData'].each do |dd|
          	res << dd if (dd[1].start_with?(str) && Integer(dd[0]) < 100000)
          end

          # include the crowd-filled db if nothing was found
          if res.empty? 
            r["aaData"].each do |dd|
              res << dd if dd[1].start_with?(str)
            end
          end

          # at last, don't filter at all 
          res=r["aaData"] if res.empty? 

          dd_cache[str]=res
          Rails.cache.write('dd_cache', dd_cache)
          res
        end
  end

  # GET /dietrairy/show
  def show
    @q = params[:q]
    if @q then
  	   @dd = get_dd_entry(@q.mb_chars.capitalize.to_s)
    else 
      @dd = []
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dd }
    end

  end


  # POST /dietrairy/show
  def showdiv
    @q = params[:q]
    if @q then
       @dd = get_dd_entry(@q.mb_chars.capitalize.to_s)
    else 
      @dd = []
    end

    respond_to do |format|
      format.json { render json: @dd }
      format.js
    end

  end  
end
