class Customer < ApplicationRecord
  include Messageable
  include UssdApis
  include Scopeable

	has_many :meterizations
	has_many :meters, through: :meterizations

	has_many :accountments
	has_many :accounts, through: :accountments

  has_many :readings
  has_many :demands
  has_many :messages
  has_many :mpesas
  has_many :equities

  has_many :incidences

  has_many :requests
  has_many :complaints

  has_many :billables



    def self.manage_account(customer,text)
      implement_back_button(text)

      if text == "7"
        response = "CON Select account type\n1.Prepaid\n2.Postpaid"
      end

      if text =~ /\A7\*1/
         response = Meterization.meter_management(customer,text,'7\*1')
      end

      if text =~ /\A7\*2/
        response = Accountment.account_management(customer,text,'7\*2')
      end

     return add_home_buttons(text,response)
    end

    def self.employee_details(staff_number)
       begin
        cursor =  Incms.connection.execute("SELECT SUBSTR (b.pernr, 4, 8) AS Staff,
                       (b.NACHN || ' ' || b.NAME2 || ' '|| b.VORNA) AS Name,
                       l.DOCN1 AS IDNO,b.gbdat  DOB,b.gbort place_of_birth,b.gblnd Nationality,l.auth1 PIN,l.icnum NSSF,l.icold NHIF,a.begda Date_of_engagement
                  FROM Pa0002@integration_sap b,
                       Pa0185@integration_sap l,
                       Pa0000@integration_sap a
                WHERE     b.PERNR = l.PERNR
                       AND a.STAT2 = '3'
                       AND a.STAT3 = '1'
                       AND a.ENDDA = '99991231'
                       AND a.ENDDA = b.endda
                       AND b.ENDDA = '99991231'
                       AND a.PERNR = l.PERNR
                       AND l.endda = '99991231'
                       AND a.endda = l.endda
                       AND b.PERNR = l.PERNR
                       AND SUBSTR (b.pernr, 4, 8) = #{staff_number}")
        row = cursor.fetch()

       if row
        response = {
             "staff_number": row[0],
             "name": row[1],
             "id_number": row[2],
             "d_o_b": row[3],
             "county_of_birth": row[4],
             "nationality": row[5],
             "kra_pin": row[6],
             "nssf": row[7],
             "nhif": row[8],
             "begda": row[9]
        }
      else
        response = {
          "failed": "Employee not found"
        }
      end
        #return row.inspect
       rescue => error
        ExceptionNotifier.notify_exception(error)
        {}
       end
  end


 def self.jua_for_sure(customer,text)
  implement_back_button(text)
    if text == "5"
      response = "CON Select Kenya Power employee to verify\n1.Staff \n2.Contractor"
    end

    if text == "5*1"
      response = "CON Enter 5 digit Staff Number"
    end

    if text =~ /\A5\*1\*(\d+)\Z/
      #customer.messages.create(:messageable => customer, :service => :find_employee, :content => id)
      response = "CON Enter National ID of employee"
    end

    if text =~ /\A5\*1\*(\d+)\*(\d+)\Z/
      staff_number = $1
      id = $2
      response = find_employee(staff_number,id)
    end



    if text == "5*2"
      response = "CON Enter National ID of contractor"
    end

    if text =~ /\A5\*2\*([^*]+)\Z/
      id = $1
      #customer.messages.create(:messageable => customer, :service => :find_contractor, :content => id)
      response = "CON #{Contractor.find_contractor(id)}"
    end
   return add_home_buttons(text,response)
 end


def self.connection_status(customer,text,ussd_vendor,sdp)
  implement_back_button(text)
    # if text == "3"
    #   response = "CON Select \n1:Apply \n2:Check status"
    # end

    # if text == "3*1"
    #   response = "CON Select application type\n1:New Connection\n2:Meter Separation"
    # end

    # if text =~ /\A3\*1\*(\d+)\Z/
    #   #customer.new_connections.create(kind: $1)
    #   response = "CON Input ID number or KRA PIN of applicant"
    # end

    # if text =~ /\A3\*1\*(\d+)\*(\d+)\Z/
    #   #customer.new_connections.create(kind: $1)
    #   response = "CON Thank you, you will be contacted shortly by our sales representative."
    #  end
    if text == "3"
      response = "CON Enter work request reference number"
    end

    if text =~ /\A3\*(.+)\Z/
      reference = $1
      work_request = HTTParty.get("http://apim.kplc.local:8281/workRequests/2.0.1/#{reference.gsub(/[^0-9A-Za-z]/, '')}/budget", :verify => false )
      given_data = work_request["data"]
      if work_request.code == 200
        response = "CON Connection status enquiry SMS will cost 10 Ksh\n1:Confirm\n2:Cancel"
      elsif work_request.code == 422
       response = "CON Incorrect work request reference number."
      end

      response
    end

    if text =~ /\A3\*(.+)\*(\d)\Z/


     if $2 == 1.to_s
      reference = $1
      work_request = HTTParty.get("http://apim.kplc.local:8281/workRequests/2.0.1/#{reference.gsub(/[^0-9A-Za-z]/, '')}/budget", :verify => false )
      given_data = work_request["data"]
      message = "CON Reference:#{given_data["workRequestReference"]}\nQuotation Date: #{given_data["quotationFormatedDate"]}\nQuotation Amount: #{given_data["quotationAmount"]}KSH\nRequest Status: #{given_data["workRequestStatus"]}"

       response =  if sdp.empty?
                    "SDP"
                   elsif sdp =~ /\ArequestId:(\d+)\|respTimeStamp:(\d+)\|status:(\d+)\|statusCode:(\d+)\|description:(.+)\Z/
                    #"CON Class: #{sdp.class} SDP:#{sdp}"
                    #"END You will receive an SMS with full token details."
                     $redis.set($1,message,ex: 600)
                           #  billable =   customer.billables.new(
                           #                    request_id: $1,
                           #                    request_timestamp: $2,
                           #                    status_code: $3,
                           #                    description: $4,
                           #                    account: meter,
                           #                    response: message
                           #                )
                           #  billable.save
                    "END Your request is being processed, kindly wait for the confirmation message."
                   end

      elsif $2 == 2.to_s
        response = "CON Thank you, connection status request cancelled."
      end

			return response




    end

   return add_home_buttons(text,response)
 end

 def get_selected(opt_1,kind)
  send(kind.pluralize).order(:number).offset(opt_1-1).first
 end

 def get_accounts(kind)
   send(kind.pluralize)
 end





### this are public methods called from other classes
  def listing_meters
    text = ""
    last = self.meters.count + 1
    self.meters.order(:number).each_with_index do |key,value|
      text += "#{value+1}:#{key.number}\n"
    end
    text += "#{last}:Add meter number"
    return text
  end

 def listing_accounts
    text = ""
    last = self.accounts.count + 1
    self.accounts.order(:number).each_with_index do |key,value|
      text += "#{value+1}:#{key.number}\n"
    end
    text += "#{last}:Add account number"
    return text
end

private


  def self.find_employee(staff_number,id)
    if staff_number =~ /\A\d{5}\Z/
        begin

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
                                            AND SUBSTR (b.pernr, 4, 8) = #{staff_number}")
        row = cursor.fetch()
        response =    if row[2] == id
                        "CON KPL#{row[0]},ID NO.#{row[2]} is a Kenya Power Employee."
                      else
                        #"CON STAFF NO.#{staff_number} ID NO.#{id} is not a Kenya Power Employee,report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
                        "CON We have not found data about the KP staff."
                      end
       rescue => error
        ExceptionNotifier.notify_exception(error)
        response = "CON The request could not be completed, try again later."
       end
    else
      response = "CON Staff number is of invalid format."
    end

    return response
  end


  def self.find_contractor(id)
    begin
    cursor = Incms.connection.execute("SELECT DISTINCT ID_NUMBER  as IDNO,STAFF_NAME AS NAME FROM CONTRACTORS_DETAIL WHERE CONTRACTORS_STATUS=1 AND ID_NUMBER=#{id}")
    row = cursor.fetch()
    response =    if row
                    "CON ID NO.#{row[0]},#{row[1]} is a Kenya Power Contractor."
                  else
                    "CON ID NO.#{id} is a fraudster, report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
                  end
    rescue => error
      ExceptionNotifier.notify_exception(error)
      response = "CON The request could not be completed, try again later."
    end

    return response
  end


end


