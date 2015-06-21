class EventsController < ApplicationController
  #shows all events
  def index
    @events = Event.all().reverse_order
  end

  #shows all events created by user
  def myevents
    @events = Event.where(host: current_user.name).reverse_order
  end

  #shows a single event
  def show
    @event = Event.find_by_id(params[:id])
  end

  #returns a html form for creating a new photo
  def new
  end

  #create a new event
  def create
    #need to make use of the time and date given by the user to create a Time object

    arrDate = params[:date].split("-")
    arrTime = params[:time].tr('A-Za-z ', '').split(":")

    #checks if the time is in PM. If yes add 12 hours to it. Special case is when its 12 AM. Need to minus 12 hours.
    if (params[:time].include? "A") && arrTime[0] == "12"
      arrTime[0] = 0
    elsif (params[:time].include? "P") && arrTime[0] != "12"
      arrTime[0] = arrTime[0].to_i + 12
    end

    event = Event.create(title: params[:title],
                         summary: params[:summary],
                         description: params[:description],
                         time: Time.new(arrDate[2], arrDate[1], arrDate[0], arrTime[0], arrTime[1]),
                         venue: params[:venue],
                         host: current_user.name)

    if event.valid?
      flash[:event_succ] = "You have successfully created an event"
    else
      flash[:event_fail] = "You have failed to create the event:("
    end
    redirect_to root_url
  end


end
