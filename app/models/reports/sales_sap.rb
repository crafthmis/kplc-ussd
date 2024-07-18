class SalesSap < Report
  self.table_name = "REPORTS.DW_SALES_FROM_SAP"

   def self.sales 
			query = <<-SQL 
				select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
				round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
				round(sum(table3.other_costs)/1000000000,2) "Other Costs",
				round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
				round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
				from 
				(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
				group by MONTH_YEAR) table1

				join
				(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
				sum(power_purchase_cost) energy_purchase_cost 
				from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
				group by month) table3 on table1.period=table3.period
				group by table1.period
				order by table1.period
			SQL
			result = Report.connection.exec_query(query)
     rescue 
     result = {}
  end

  def self.energy_purchase_cost
	  query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
	  SQL
	result = Report.connection.exec_query(query)
     rescue 
     result = {}
  end

  def self.other_costs
	query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
	SQL
	result = Report.connection.exec_query(query)
	rescue 
     result = {}
  end

  def self.profit 
  	query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
  	SQL
  	result = Report.connection.exec_query(query)
     rescue 
     result = {}
  end

  def self.sales_vs_cost_trend
    query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
    SQL
    result = Report.connection.exec_query(query)
    rescue 
     result = {}
  end

end

