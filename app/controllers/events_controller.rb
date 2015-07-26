class EventsController < ApplicationController
  #shows all events
  def index
    @events = Event.all().reverse_order
  end

  #shows all events created by user
  def myevents
    @events = Event.where(host: current_user.name).reverse_order
    @option = 1    #renders the edit and delete button instead of info and join
  end

  #shows a single event
  def show
    @event = Event.find_by_id(params[:id])
  end

  #search for events
  def search
    @events = Event.search(params[:query])
  end

  #returns a html form for creating a new photo
  def new
  end

  def edit
    @event = Event.find(params[:id])
  end

  #create a new event
  def create
    event = Event.create(title: params[:title],
                         summary: params[:summary],
                         description: params[:description],
                         time: makeDate(params[:date], params[:time]),
                         venue: params[:venue],
                         host: current_user.name)

    if event.valid?
      flash[:event_succ] = "You have successfully created an event"
    else
      flash[:event_fail] = "You have failed to create the event:("
    end
    redirect_to root_url
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(title: params[:title],
                     summary: params[:summary],
                     description: params[:description],
                     time: makeDate(params[:date], params[:time]),
                     venue: params[:venue])
      flash[:event_succ] = "You have successfully updated your event"
    else
      flash[:event_fail] = "You have failed to update the event:("
    end
    redirect_to events_myevents_url
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:event_succ] = "You have successfully deleted your event"
    else
      flash[:event_fail] = "You have failed to delete the event:("
    end
    redirect_to events_myevents_url
  end

  #makes use of the time and date given by the user in the form to create a Time object
  def makeDate date, time
    arrDate = date.split("-")
    arrTime = time.tr('A-Za-z ', '').split(":")

    #checks if the time is in PM. If yes add 12 hours to it. Special case is when its 12 AM. Need to minus 12 hours.
    if (params[:time].include? "A") && arrTime[0] == "12"
      arrTime[0] = 0
    elsif (params[:time].include? "P") && arrTime[0] != "12"
      arrTime[0] = arrTime[0].to_i + 12
    end

    return Time.new(arrDate[2], arrDate[1], arrDate[0], arrTime[0], arrTime[1])
  end


end
