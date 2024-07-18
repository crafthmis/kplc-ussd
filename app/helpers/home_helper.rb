module HomeHelper

	def request_bar_data(r,prep,post,power,jua,period,manage)
		prepaid_requests = prep.group_by_period(period,:created_at ,format: "%H:00 %d %b",series: true , permit: ["day", "hour","month"]).count
		postpaid_requests = post.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		power_failure = power.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		jua_for_sure = jua.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		manage_account = manage.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		total_request = r.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true , permit: ["day", "hour","month"]).count



		chart_data = [{ name: "Total Requests" ,data: total_request },
			          { name: "Prepaid Request" ,data: prepaid_requests },
			          { name: "Postpaid Request" ,data: postpaid_requests},
			          { name: "Power Failure" ,data: power_failure},
			          { name: "Jua For Sure" ,data: jua_for_sure},
			          { name: "Manage Account" ,data: manage_account}]
		# requests.group_by_day(:created_at, format: "%d %b").count.each do |key,value|
		# 	request_chart_data << { 
		# 		request_date: key,
		# 		traffic: value, 
		# 		new_customers: grouped_customers[key] || 0
		# 	}
		# end
		return request_chart_data
	end


	def confirmation_by_hour(confirm)
		#     batch: 0,
  #   pending: 1,  ###if pending for >> long check if token is generated ,send and change status ?
  #   successfull: 2,
  #   pending_top_up: 6, ##customer tops up ,if meter is vending combine two amounts and send one message, change the billrefnumber or meter number 
  #   completed_top_up: 17,
  #   invalid_meter: 12,
  #   meter_blocked: 98 ,
  #   invalid_amount: 96,
  #   unknown_meter: 97,  ##Meter number should not be changed
  #   blocked_for_reversal: 15,
  #   reversed_by_safaricom: 11,
  #   evg_timeout: 80,
  #   itron_busy: 99
    
		# chart_data = [{ name: "Total Requests" ,data: total_request },
		# 	          { name: "Prepaid Request" ,data: prepaid_requests },
		# 	          { name: "Postpaid Request" ,data: postpaid_requests},
		# 	          { name: "Power Failure" ,data: power_failure},
		# 	          { name: "Jua For Sure" ,data: jua_for_sure},
		# 	          { name: "Manage Account" ,data: manage_account}]

	end


	def request_by_hour(r,prep,post,power,jua,period,manage)
		prepaid_requests = prep.group_by_period(period,:created_at ,format: "%H:00 %d %b",series: true , permit: ["day", "hour","month"]).count
		postpaid_requests = post.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		power_failure = power.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		jua_for_sure = jua.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		manage_account = manage.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true ,permit: ["day", "hour","month"]).count
		total_request = r.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true , permit: ["day", "hour","month"]).count



		chart_data = [{ name: "Total Requests" ,data: total_request },
			          { name: "Prepaid Request" ,data: prepaid_requests },
			          { name: "Postpaid Request" ,data: postpaid_requests},
			          { name: "Power Failure" ,data: power_failure},
			          { name: "Jua For Sure" ,data: jua_for_sure},
			          { name: "Manage Account" ,data: manage_account}]
		#r.group_by_period(period,:created_at ,format: "%H:00 %d %b", series: true, permit: ["day", "hour","month"]).count.each do |key,value|
		# 	chart_data << {
		# 		name: key, #"%d %b %-l %P"
		# 		data:[
		# 		traffic: value, 
		# 		prepaid: prepaid_requests[key] || 0,
		# 		postpaid: postpaid_requests[key] || 0,
		# 		power_failure: power_failure[key] || 0,
		# 		jua_for_sure: jua_for_sure[key] || 0,
		# 		manage_account: manage_account[key] || 0 ]
		# 	}
		# end
		#return chart_data
		return chart_data
	end

	# def new_ussd_users(customers)
	# 	chart_data = []  
	# 	customers.group_by_day(:created_at , format: "%d %b").count.each do |key,value|
	# 		chart_data << {
	# 			day_registered: key,
	# 			number: value 
	# 		}
	# 	end
	# 	return chart_data
	# end

	def popular_groups
		[
		    {label: "Pay Bill", value: 30},
		    {label: "Power Failure", value: 15},
		    {label: "Buy Token", value: 45},
		    {label: "Jua For Sure", value: 10}
		  ]
	end

end


