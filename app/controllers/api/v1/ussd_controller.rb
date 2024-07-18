require 'httparty'
class Api::V1::UssdController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  before_action :set_variables
  before_action :set_customer
  before_action :implement_home_button

  # /\A5\*2\*([^*]+)\Z/ followed by anything but star

  def index   #TODO: Instead of running process all the way down ,use an if statement etc ,and tweak the middleware as well

    if @ussd_string == ""
      response = "CON Welcome to Kenya Power\n1:Prepaid Services(Token)\n2:Postpaid Services(Bill)\n3:New Connections\n4:Report Incidences\n5:Jua For Sure\n6:Billing Complaints"#\n7:Manage Accounts" #"6:File Complaint"
      #response = "CON Welcome to Kenya Power\n1:Prepaid Services(Token)\n2:Postpaid Services(Bill)\n3:Report Power-Failure\n4:Jua For Sure\n5:File Complaint"#\n6:Manage Accounts"
    end

    # https://blog.arkency.com/2014/07/4-ways-to-early-return-from-a-rails-controller/ to return early but check action controller bare metals
    # if @ussd_string =~ /\A1.*\Z/
    #   response = Meter.prepaid(@customer,@ussd_string,@kind)
    # elsif @ussd_string =~ /\A2.*\Z/
    #   response = Account.postpaid(@customer,@ussd_string,@kind)
    # elsif @ussd_string =~ /\A3.*\Z/
    #   response = NewConnection.check_status(@customer,@ussd_string,@kind)
    # elsif @ussd_string =~ /\A4.*\Z/
    #   response = Customer.jua_for_sure(@customer,@ussd_string)
    # elsif @ussd_string =~ /\A5.*\Z/
    #   #response = Complaint.register(@customer,@ussd_string,@kind)
    #   response = Customer.report(@customer,@ussd_string,@kind)
    # elsif @ussd_string =~ /\A6.*\Z/
    #   response = Accountment.account_management(@customer,@ussd_string)
    # end

   if @ussd_string =~ /\A1.*\Z/
      response = Meter.prepaid(@customer,@ussd_string,@kind,@sdp)
     # print ">>>>>>>>>>>>>>>>>>>>Response: #{response} Time:#{Time.now.inspect}\n"
    elsif @ussd_string =~ /\A2.*\Z/
      response = Account.postpaid(@customer,@ussd_string,@kind,@sdp)
    elsif @ussd_string =~ /\A3.*\Z/
      response = Customer.connection_status(@customer,@ussd_string,@kind,@sdp)
    elsif @ussd_string =~ /\A4.*\Z/
      response = Incidence.report_incidence(@customer,@ussd_string,@kind,@sdp)
    elsif @ussd_string =~ /\A5.*\Z/
      response = Customer.jua_for_sure(@customer,@ussd_string)
    elsif @ussd_string =~ /\A6.*\Z/
      response = BillingComplaint.register(@customer,@ussd_string,@kind,@sdp)
      #response = Complaint.register(@customer,@ussd_string,@kind)
    elsif @ussd_string =~ /\A7.*\Z/
      response = Customer.manage_account(@customer,@ussd_string)
    end


    if @kind == "equitell_ussd"
     xml_response = {
                    "requestId"      =>      @request_id,
                    "msisdn"      =>      @phone_number,
                    "starCode"      =>      "*977#",
                    "langId"      =>      "1",
                    "encodingScheme"      =>      "0",
                    "dataSet"      => {
                       "param"         =>{
                          "id"            =>            "1",
                          "value"            =>   equitell_convert_response(response),
                          "rspFlag"            =>           equitell_convert_flag(response),
                          "rspTag"            =>            "kplc",
                          "rspURL"            =>            "http://172.16.29.11/api/v1/ussd/index",
                          "appendIndex"            =>            "0",
                          "default"            =>            "1"
                       }
                    },
                    "ErrCode"      =>      "1",
                    "errURL"      =>      "http://172.16.29.11/api/v1/ussd/index",
                    "timeStamp"      =>      ""
                 }.to_xml(:root => 'USSDDynMenuResponse', :skip_instruct => true, :indent => 2)

      #HTTParty.post("http://196.216.242.149:3215/USSD/Servlet/DynTPHttpAdapter", :body => xml_response, :headers => {'Content-type' => 'text/xml'}, :verify => false)
      render  xml: xml_response,status: :ok
    else
      render  json: response,status: :ok
    end


    #Rails.logger.debug "RESPONSE: #{response}" if Rails.logger.debug?


  end


private
  # {"requestId"=>"125432", "msisdn"=>"07167492343", "timeStamp"=>"2018/01/24 08:23:28", "starCode"=>"*977#", "keyWord"=>"nhif",
  #  "dataSet"=>{"param"=>[{"id"=>"CIRCLEID", "value"=>"1"}, {"id"=>"CIRCLE_ID", "value"=>"1"}, {"id"=>"DIAL-CODE", "value"=>"*123#"},
  #   {"id"=>"SESSION_ID", "value"=>"2i3345454"}, {"id"=>"TRAVERSAL-PATH", "value"=>"123"}]}, "userData"=>"*123#"}
  def set_variables
    if request.method == "POST" && Rails.env.production? #&& request.url == "facebook"
      xml = request.body.read
      received = Hash.from_xml(xml)
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>Equitell Hash: #{received.inspect}"
      @request_id = received["USSDDynMenuRequest"]["requestId"]
      @phone_number = received["USSDDynMenuRequest"]["msisdn"]
      @ussd_string = received["USSDDynMenuRequest"]["dataSet"]["param"][4]["value"].gsub(/(^977\*?)/, "")
      @session_id = received["USSDDynMenuRequest"]["dataSet"]["param"][3]["value"]
      @sdp = ""
      @kind = "equitell_ussd"
    else
        if params['service_code'] == "977"
          @ussd_string = params['ussd_string']
          @kind = "saf_ussd"
          @sdp = params['sdp_string']
        elsif params['service_code'] == "167"  ##Test ussd
          @ussd_string = params['ussd_string'].gsub(/(^97\*?)/, "")
          @kind = "saf_ussd"
          @sdp = params['sdp_string']
        elsif params['service_code'] == "195"
          @ussd_string = params['ussd_string'].gsub(/(^42\*?)/, "")
          @kind = "saf_ussd"
          @sdp = params['sdp_string']
        else
          @ussd_string = params['text']
          @sdp = ""
          @kind = "africas_ussd"
        end
        @phone_number = params["MSISDN"] || params['phoneNumber']
        @session_id = params["session_id"] || params["SESSION_ID"] || params['sessionId']
    end
  end

  def set_customer
    @customer = Customer.find_or_create_by(number: @phone_number)  #Remember to eagerload here the meter numbers and also to load the customer only on the first instance using dalli gem
    RequestWorker.perform_async(@session_id,@phone_number,@ussd_string,@kind,@customer.id)
  end

  def equitell_convert_flag(response)
    if response.include? "CON"
      "1"
    else
      "2"
    end
  end

  def equitell_convert_response(response)
    response.sub(/^.{3}\s/, '')
  end

  def implement_home_button
    @ussd_string = @ussd_string.gsub(/.+\*00\*?/, "")  ##TODO: Test the home button
  end


end




