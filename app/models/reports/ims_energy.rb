class ImsEnergy < Report
  self.table_name = "REPORTS.DW_IMS_UNSERVED_ENERGY"
  #self.primary_key = "trn_id"

  


  def self.weekly_unserved_energy
	query = <<-SQL 
		SELECT
		  to_char( trunc( Detection_Date, 'IW' ), 'yyyymmdd' ) WEEK_START_DATE,
		round (sum(Loss_Million_Ksh),2)  Loss_Millon  
		FROM   REPORTS.DW_IMS_unserved_Energy
		WHERE Detection_Date BETWEEN trunc( sysdate, 'IW' ) - 28 AND trunc( sysdate )
		GROUP BY trunc( Detection_Date, 'IW' )
		ORDER BY 1   
	SQL
	result = Report.connection.exec_query(query)
  end

  def self.weekly_regional_trend(region)  ##get regions select distinct region from REPORTS.DW_IMS_unserved_Energy; 'North Eastern'
  	# query = <<-SQL 

   #  SQL
	result = Report.connection.exec_query("
		SELECT region ,
		              to_char( trunc( Detection_Date, 'IW' ), 'yyyymmdd' ) WEEK_START_DATE,
		            round (sum(Loss_Million_Ksh),2)  Loss_Millon  
		            FROM   REPORTS.DW_IMS_unserved_Energy
		WHERE Detection_Date BETWEEN trunc( sysdate, 'IW' ) - 28 AND trunc( sysdate ) 
		and region = #{region}
		GROUP BY trunc( Detection_Date, 'IW' ),region
		ORDER BY 1")
  end




end 
