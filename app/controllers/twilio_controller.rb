require 'twilio-ruby'
require 'pry'
require 'alert_transaction'
require 'message_parser'

class TwilioController < ApplicationController
  # include Webhookable
    before_action :load_user, only: :receive_sms
#   after_filter :set_header
#  
#   skip_before_action :verify_authenticity_token


  @@messages = []

  def index
  end

  def send_sms
    twilio_phone_number = "2892781799"
    current_time = Time.now
    @twilio_client = Twilio::REST::Client.new(Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token)
    @twilio_client.account.messages.create({
      :from => "+1#{twilio_phone_number}",
      :to => 6479625447,
      :body => "Testing out Twilio SMS at #{current_time}"
    })
    redirect_to alerts_url
  end

  def receive_sms
    body = params[:Body].upcase
    senderNumber = params[:From]
    twilio_phone_number = "2892781799"
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Thank you for your message <3"     
    end
    render :text => twiml.text, :content_type => "text/xml"

    puts "Received sms #{body}"
      action = MessageParser.parse(body, senderNumber)
      operator = action.getCurrentOperator
      keyword = action.getCurrentKeyword
      number = action.getNumber

    if @user.empty?
      @user = User.new(phone_number: senderNumber)
      if @user.save
        puts "New user created"
      else
        puts "User could not be created"
      end
    end   

    case operator
      when "ADD" then puts "Adding this user"
      when "SUBSCRIBE" then puts "Unsubscribing this user"
      when "REMOVE" then puts "Removing this user"
      when "UNSUBSCRIBE" then puts "Unsubscribing this user"
    end

    puts "Done Parse"

  end

  def check_messages
    @messages = @@messages
    #binding.pry
  end

  protected

  # def user_params
  #   phone_number = params[:From]
  #   params.require(:user).permit(
  #     phone_number)
  # end

  def load_user
    @user = User.where(phone_number: params[:From])
  end

end
