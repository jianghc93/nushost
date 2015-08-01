class EventsController < ApplicationController
  #shows all events
  def index
    @events = Event.all.reverse_order
    #renders the info and join button
    @btn1 = "info"
    @btn2 = "join"
  end

  #shows all events created by user
  def myevents
    @events = []
    participants = current_user.participants.where("role = ?", "host").reverse_order
    participants.each do |p|
      @events << p.event
    end
    #renders the edit and delete button
    @btn1 = "edit"
    @btn2 = "delete"
  end

  #shows a single event
  def show
    @event = Event.find_by_id(params[:id])
    @num_participants = @event.users.size
    #event.participants returns a collection and we CANT perform query on it
    host = @event.participants.select { |p| p.role == "host" }
    @users = @event.users.select { |u| u.id != host.first.user_id }     #excludes the host
  end

  #search for events
  def search
    @events = Event.search(params[:query])
    @btn1 = "info"
    @btn2 = "join"
  end

  #returns a html form for creating a new photo
  def new
  end

  def edit
    @event = Event.find(params[:id])
  end

  #create a new event
  def create
    user = current_user
    event = Event.create(title: params[:title],
                         summary: params[:summary],
                         description: params[:description],
                         time: makeDate(params[:date], params[:time]),
                         venue: params[:venue],
                         host: user.name)

    if event.valid?
      Participant.create(user_id: user.id,
                         event_id: event.id,
                         role: "host")
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

  def join
    user = current_user
    part = Participant.create(user_id: user.id,
                              event_id: params[:id])
    if part.valid?
      flash[:event_succ] = "You have successfully joined "
    else
      flash[:event_fail] = "You have failed to join"
    end
    redirect_to event_path(params[:id])
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
