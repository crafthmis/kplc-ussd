class Connectivity < Report
  self.table_name = "REPORTS.DW_CONNECTIVITY"
  #self.primary_key = "trn_id"

  


  def self.ytd_mtd_performance
	query = <<-SQL 
		SELECT REGION,TARGET_FY2019_2020,MONTHLY_TARGET,CUM_TARGET_DATEADDRESSED FY_CUM_TARGET,YTD_PERFORMANCE_DATEADDRESSED YTD_PERFORMANCE,
		(YTD_PERFORMANCE_DATEADDRESSED - CUM_TARGET_DATEADDRESSED) YTD_VARIANCE,
		MTD_TARGET_DATEADDRESSED MTD_TARGET,MTD_PERFORMANCE_DATEADDRESSED MTD_PERFORMANCE,
		(MTD_PERFORMANCE_DATEADDRESSED - MTD_TARGET_DATEADDRESSED) MTD_VARIANCE
		FROM reports.DW_CONNECTIVITY 
		WHERE DATE_ADDRESSED=(select max(DATE_ADDRESSED)FROM REPORTS.DW_CONNECTIVITY)
	SQL
	result = Report.connection.exec_query(query)
  end

  def self.fy_target_cum_target_ytd_performance  ##get regions select distinct region from REPORTS.DW_IMS_unserved_Energy; 'North Eastern'
  	 query = <<-SQL 
		SELECT REGION,TARGET_FY2019_2020,MONTHLY_TARGET,CUM_TARGET_DATEADDRESSED FY_CUM_TARGET,YTD_PERFORMANCE_DATEADDRESSED YTD_PERFORMANCE,
		MTD_TARGET_DATEADDRESSED MTD_TARGET,MTD_PERFORMANCE_DATEADDRESSED MTD_PERFORMANCE
		 FROM reports.DW_CONNECTIVITY 
		 WHERE DATE_ADDRESSED=(select max(DATE_ADDRESSED)FROM REPORTS.DW_CONNECTIVITY)
     SQL
	result = Report.connection.exec_query(query)
  end

  def self.ytd_variance 
    query = <<-SQL 
		SELECT REGION,( YTD_PERFORMANCE_DATEADDRESSED -CUM_TARGET_DATEADDRESSED) VARIANCE
		FROM reports.DW_CONNECTIVITY 
		WHERE DATE_ADDRESSED=(select max(DATE_ADDRESSED)FROM REPORTS.DW_CONNECTIVITY)
    SQL
    result = Report.connection.exec_query(query)
  end


  def self.mtd_variance  ##get regions select distinct region from REPORTS.DW_IMS_unserved_Energy; 'North Eastern'
  	 query = <<-SQL 
		SELECT REGION,(MTD_PERFORMANCE_DATEADDRESSED -MTD_TARGET_DATEADDRESSED) MTD_VARIANCE
		FROM reports.DW_CONNECTIVITY 
		WHERE DATE_ADDRESSED=(select max(DATE_ADDRESSED)FROM REPORTS.DW_CONNECTIVITY)
     SQL

	result = Report.connection.exec_query(query)
  end

  def self.connectivity_trend
    query = <<-SQL 
		select to_char(to_date(MONTH,'yyyymm'),'Mon')||' - '||substr(MONTH,1,4) MONTH_NAME,month, NEW_CONNECTIONS 
		from REPORTS.DW_CONNECTIVITY_MONTHLY_TREND WHERE NEW_CONNECTIONS>0
		ORDER BY MONTH
    SQL
    result = Report.connection.exec_query(query)
  end


  
end 
