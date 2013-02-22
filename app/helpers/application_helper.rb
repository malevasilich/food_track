# encoding: utf-8
require "open-uri"

module ApplicationHelper

	def get_dd_entry(str)
	        if APP_CONFIG['http_proxy'].present?
	                proxy = {proxy_http_basic_authentication: [APP_CONFIG['http_proxy'],
	                                                           APP_CONFIG['http_proxy_username'],
	                                                           APP_CONFIG['http_proxy_password']]}
	        end

  dietdairy_url = "http://dietadiary.com/meal/food/json?sEcho=2&iColumns=7&sColumns=&iDisplayStart=0&iDisplayLength=10&sNames=%2C%2C%2C%2C%2C%2C&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=true&sSearch_4=&bRegex_4=false&bSearchable_4=true&sSearch_5=&bRegex_5=false&bSearchable_5=true&sSearch_6=&bRegex_6=false&bSearchable_6=true&iSortingCols=1&iSortCol_0=1&sSortDir_0=asc&bSortable_0=true&bSortable_1=true&bSortable_2=true&bSortable_3=true&bSortable_4=true&bSortable_5=true&bSortable_6=true&main=1&_=1361418562484"
         proxy = {proxy_http_basic_authentication: ["HTTP://border.kkb.kz:80", "AArzamasov", "qweasdZXC00"]}

        j = open(dietdairy_url+"&sSearch="+URI.escape("Помидор"), proxy).read
        r=JSON.parse(j)
        r["aaData"]
	end
end
