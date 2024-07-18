class UnservedEnergy < Report
  self.table_name = "REPORTS.UNSERVED_ENERGY"
  #self.primary_key = "trn_id"

  


  def self.unserved_energy_table
    query = <<-SQL 
		select region,actual_2018_2019,monthly_average_2018_2019,cumulative_total_2018_2019,non_programmed,programmed,
		cum_achievement_2019_2020 , variance_ FROM REPORTS.UNSERVED_ENERGY
		where date_done=(select max(date_done) from reports.UNSERVED_ENERGY)
    SQL
    result = Report.connection.exec_query(query)
  end



def self.unserved_e_t(allocation_keys)
  UnservedEnergy.find_by_sql([<<-SQL, keys: allocation_keys])
    select region,actual_2018_2019,monthly_average_2018_2019,cumulative_total_2018_2019,non_programmed,programmed,
     cum_achievement_2019_2020 , variance_ FROM REPORTS.UNSERVED_ENERGY
    where date_done=(select max(date_done) from reports.UNSERVED_ENERGY)
  SQL
end



  # ActiveRecord::Base.connection.select_all(sql).rows.map do |account, email, fullname, holdings, value|
  #   [account, email, fullname, Integer(holdings), Float(value)]
  # end

  def self.unserved_energy_chart
  	query = <<-SQL 
  	  SELECT region,cumulative_total_2018_2019,cum_achievement_2019_2020 , variance_
	  FROM REPORTS.UNSERVED_ENERGY
      where date_done=(select max(date_done) from reports.UNSERVED_ENERGY)
    SQL
    result = Report.connection.exec_query(query)
  end


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
    result = Report.connection.select_all(query)
  end

  def self.trend_by_region(region)
    UnservedEnergy.find_by_sql([<<-SQL, keys: region])
        SELECT region ,
                      to_char( trunc( Detection_Date, 'IW' ), 'yyyymmdd' ) WEEK_START_DATE,
                    round (sum(Loss_Million_Ksh),2)  Loss_Millon  
                    FROM   REPORTS.DW_IMS_unserved_Energy
        WHERE Detection_Date BETWEEN trunc( sysdate, 'IW' ) - 28 AND trunc( sysdate ) 
        and region = :keys 
        GROUP BY trunc( Detection_Date, 'IW' ),region
        ORDER BY 1
      SQL
  end

  def self.weekly_regional_trend 
    query = <<-SQL 
      SELECT region ,
                    to_char( trunc( Detection_Date, 'IW' ), 'yyyymmdd' ) WEEK_START_DATE,
                  round (sum(Loss_Million_Ksh),2)  Loss_Millon  
                  FROM   REPORTS.DW_IMS_unserved_Energy
      WHERE Detection_Date BETWEEN trunc( sysdate, 'IW' ) - 28 AND trunc( sysdate ) 
      and region = 'North Eastern'
      GROUP BY trunc( Detection_Date, 'IW' ),region
      ORDER BY 1
    SQL
    result = Report.connection.exec_query(query)
  end



end 
