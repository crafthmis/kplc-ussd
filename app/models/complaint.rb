class Complaint < ApplicationRecord
  paginates_per 50

  belongs_to :customer
  belongs_to :complaintable, polymorphic: true


  CORRUPTION =  {"1".to_sym => "Rude", "2".to_sym => "Corrupt", "3".to_sym => "Others"}

  include UssdApis

 include AASM
  aasm column: :state do
    state :open, initial: true
    state :closed

    event :resolve do
      transitions from: :open, to: :closed
    end

    event :unresolve do
      transitions from: :closed, to: :open 
    end

  end




  def self.complaint_types 
    query = <<-SQL 
      SELECT DISTINCT
         AC.COD_DEVELOP          COD_CLASS,
         AC.NAME_TYPE            CLASS_NAME,
         COMPT.ID_COMPLAINT_TYPE ID_COMPLAINT,
         COMPT.NAME_TYPE         COMPLAINT_TYPE
      FROM
         GCCC_COMPLAINT_CLASS AC
         INNER JOIN GCCC_CLASS_COMPLAINT_ASOC GCCA
         ON AC.COD_DEVELOP = GCCA.COD_CLASS
         INNER JOIN GCCC_COMPLAINT_TYPE COMPT
         ON COMPT.ID_COMPLAINT_TYPE = GCCA.ID_COMPLAINT_TYPE
      ORDER BY 1
    SQL
  result = Incms.connection.exec_query(query)
  end


 def self.staff_misconduct(customer,text,ussd_vendor)
    if text =~ /\A4\*3\Z/
      response = "CON Enter employee's 5 digit staff number"
    end

    if text =~ /\A4\*3\*(\d+)\Z/
      id = $1
       if id =~ /\A\d{5}\Z/
            cursor =  Incms.connection.execute("SELECT SUBSTR (b.pernr, 4, 8) AS Staff,
                                            (b.NACHN || ' ' || b.NAME2 || ' '|| b.VORNA) AS Name,
                                            l.DOCN1 AS IDNO
                                            FROM Pa0002@integration_sap b,
                                            Pa0185@integration_sap l,
                                            Pa0000@integration_sap a
                                            WHERE b.PERNR = l.PERNR
                                            AND a.STAT2 = '3'
                                            AND a.STAT3 = '1'
                                            AND a.ENDDA = '99991231'
                                            AND a.ENDDA = b.endda
                                            AND b.ENDDA = '99991231'
                                            AND a.PERNR = l.PERNR
                                            AND l.endda = '99991231'
                                            AND a.endda = l.endda
                                            AND b.PERNR = l.PERNR
                                            AND SUBSTR (b.pernr, 4, 8) = #{id}")
        row = cursor.fetch()
        response =    if row
                        "CON KPL#{row[0]} was\n1:Rude\n2:Corrupt\n3:Others"
                      else
                        "CON STAFF NO.#{id} is a fraudstar, report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
                      end
    else
      response = "CON Staff number is of invalid format."
    end
    return response
   end

   if text =~ /\A4\*3\*(\d+)\*(\d+)\Z/
     employee = Employee.find_or_create_by(staff_number: $1)
     complaint = customer.complaints.create(:complaintable => employee,info: $2)
     response = "CON Complaint against KPL#{employee.staff_number} has been created. Reference ##{complaint.id}"
   end
   return response
 end

 def self.register(customer,text,ussd_vendor)
   implement_back_button(text)
    if text == "6"
     response = "CON Select complaint\n1:Faulty meter\n2:High bill\n3:Report employee"
    end

    if text =~ /\A6\*1\Z/
      response = "CON Sorry, this service is not available"
    	#response = "CON Meter type\n1:Prepaid meter\n2:Postpaid meter"
    end

    if text =~ /\A6\*1\*1.*\Z/
      next_prompt = lambda { |meter,customer,text,kind,option| meter_complaint(meter,customer,text,kind,option)}
      last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor| last_method(meter,second_param,customer,text,kind,option,ussd_vendor)}
      response = initialize_profile(customer,text,'5\*1\*1','meter',next_prompt,last_prompt,ussd_vendor) 
    end

    if text =~ /\A6\*1\*2.*\Z/
      next_prompt = lambda { |meter,customer,text,kind,option| meter_complaint(meter,customer,text,kind,option)}
      last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor| last_method(meter,second_param,customer,text,kind,option,ussd_vendor)}
      response = initialize_profile(customer,text,'5\*1\*2','account',next_prompt,last_prompt,ussd_vendor) 
    end

    if text =~ /\A6\*2.*\Z/
     next_prompt = lambda { |account,customer,text,kind,option| current_reading(account,customer,text,kind,option)}
     last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor| save_reading(meter,second_param,customer,text,kind,option,ussd_vendor)}
     response = initialize_profile(customer,text,'5\*2','account',next_prompt,last_prompt,ussd_vendor) 
    end
  return add_home_buttons(text,response)
 end


private 

 def self.meter_complaint(meter,customer,text,kind,option)
	  if kind == "meter"
      complaint_prepaid  =  {
                                "rccsType": "{appropriate RCCSTYPE}",
                                "deviceNumber": meter.number,
                                "phoneNumber": "0#{customer.number.split("").last(9).join}"
                            }  
      response = HTTParty.post("#{ENV['apim_url']}/rccs/#{ENV['apim_version']}/complaintMeter", body: complaint_prepaid.to_json ,:headers => headers,verify: false)
	  elsif kind == "account"
	    complaint_postpaid = {
                              "accountNumber": meter.number,
                              "phoneNumber": "0#{customer.number.split("").last(9).join}"
                            }
      response = HTTParty.post("#{ENV['apim_url']}/rccs/#{ENV['apim_version']}/complaintFaultyMeter", body: complaint_postpaid.to_json ,:headers => headers,verify: false)
	  end

    #token = response["token"]	  #response = "CON #{kind.titleize} No:#{meter.number} complaint has been filed. Reference #{complaint.id}"
    response = "CON #{response}"
     
   return response 
 end

 def self.current_reading(meter,customer,text,kind,option)
  response = "CON Sorry, this service is not available"
  #response = "CON Input current reading for #{kind.titleize} No:#{meter.number}"
  return response 
 end

 def self.last_method(meter,second_param,customer,text,kind,option,ussd_vendor)
   response = nil
 end


  def self.save_reading(meter,second_param,customer,text,kind,option,ussd_vendor)
     if text =~ /\A#{option}\*\d+\*(\d+)\Z/ 
        postpaid_account = Accountment.where(customer_id: customer.id).where(account_id: meter.id).first
        complaint = customer.complaints.create(:complaintable => postpaid_account,info: $1)
        response = "CON #{kind.titleize} No:#{meter.number} complaint has been filed. Reference #{complaint.id}"
      end
  return response
 end


  def self.headers 
    headers = {
                "Content-Type" =>  "application/json",
                "X-Requested-With" =>  "XMLHttpRequest"
              }
  end

end
