module InternalApis
 extend ActiveSupport::Concern

  def find_employee(id)
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
                        "KPL#{row[0]},#{row[1]},ID NO.#{row[2]} is a Kenya Power Employee."
                      else
                        "STAFF NO.#{id} is a fraudstar, report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
                      end
    else
      response = "Staff number is of invalid format."
    end
    return response
  end


  def find_contractor(id)
    response = Contractor.find_contractor(id)
    #cursor = Incms.connection.execute("SELECT DISTINCT ID_NUMBER  as IDNO,STAFF_NAME AS NAME FROM CONTRACTORS_DETAIL WHERE CONTRACTORS_STATUS=1 AND ID_NUMBER= #{id}")
    #row = cursor.fetch()
    #response =    if row
    #                "ID NO.#{row[0]},#{row[1]} is a Kenya Power Contractor."
    #              else
    #                "ID NO.#{id} is a fraudstar, report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
    #              end
    return response
  end


  def find_postpaid_balance(meter)
   text = HTTParty.get("http://apim.kplc.local:80/accounts/2.0.1/#{meter}/balance", :verify => false )
   response = if text["data"]
          "Account: #{text["data"]["accountReference"]}\nName: #{text["data"]["fullName"]}\nBalance: #{text["data"]["formatedBalance"]} Ksh #{text["data"]["balance"] > 0 ? "Overpayment" : ""}\nLatest Bill: #{text["data"]["lastAmount"]} Ksh\nDue Date: #{text["data"]["formatedDueDate"]}\nLast Reading: #{find_the_last_reading(meter)}"
		      elsif text["msgDeveloper"]
		     	"#{text["msgDeveloper"]}"
		      else
		     	"We could not find your balance,kindly call us on 97771"  #Change this to 97771
		      end
    return response
  end

  def find_previous_token(meter)
   token = HTTParty.get("http://incms.kplc.local/InCMS-ss-server/services/publicData/?serialNumberMeter=#{meter}", :verify => false )
   response = if token["data"]
              "Your last token number is #{token["data"]["colPrepayment"][0]["tokenNo"]}"
             elsif token["msgDeveloper"]
              "The meter serial number doesn't exist."
             end
    return response
  end


  def report_power_failure(account,message,number)
   text = HTTParty.get("http://prsc01-ingriddb-scan.kplc.local:8090/KEIOPEN/iopen/lodge/#{account}/SMS/#{number}/1/1/#{message.gsub(/[^0-9A-Za-z]/, '')}/", :verify => false )
   return text
  end


  def find_the_last_reading(account)
      headers = {
      "Content-Type" =>  "application/json",
       "X-Requested-With" =>  "XMLHttpRequest",
       "Authorization" => "Bearer e12c9c6461e1920dcee77b9a4027609a"
       #"Authorization" => "Bearer #{ENV['apim_token']}"
      }
      incms = HTTParty.get("http://172.16.111.73/api/publicData/2.0.1/?accountReference=#{account}" ,:headers => headers,verify: false)
      return incms["data"]["meterList"].first["latestUsageList"][0]["readingValue"]
  end



  # def three_previous_tokens(meter)
  #    token = HTTParty.get("http://incms.kplc.local/InCMS-ss-server/services/publicData/?serialNumberMeter=#{meter}", :verify => false )
  #      if token["data"]
  #         response = "Last three tokens for Meter No. #{meter}\n"
  #         token['data']['colPrepayment'].first(3).each_with_index do |key,value|
  #           response += "#{value + 1}: #{key['tokenNo']}\n"
  #        end
  #       elsif token["msgDeveloper"]
  #         response = "#{token["msgDeveloper"]}"
  #       else
  #         response =  "We could not find your previous token,kindly call us on 97771"  #Change this to 97771
  #       end
  #    return response
  # end

end
