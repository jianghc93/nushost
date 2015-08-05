class EventsController < ApplicationController
  #shows all events except for those that are expired
  def index
    @events = []
    events = Event.all.reverse_order
    events.each do |e|
      if Time.new < e.time
        @events << e
      end
    end
    #renders the info and join button
    @btn1 = "info"
    @btn2 = "join"
  end

  #shows all events that user is going to
  def myevents
    @events = User.find(session[:user_id]).events.reverse_order
    #renders the info and join button
    @btn1 = "info"
    @btn2 = "join"
  end

  #shows all events created by user
  def manage
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
    if !@event.isHost? session[:user_id]
      flash[:event_fail] = "You cannot edit this event:("
      redirect_to root_url
    end
  end

  #create a new event
  def create
    user = current_user
    if(params[:usemap] == "true")
      event = Event.create(title: params[:title],
                           summary: params[:summary],
                           description: params[:description],
                           time: makeDate(params[:date], params[:time]),
                           venue: params[:venue],
                           host: user.name,
                           lat: params[:map_lat],
                           lng: params[:map_lng])
    else
      event = Event.create(title: params[:title],
                           summary: params[:summary],
                           description: params[:description],
                           time: makeDate(params[:date], params[:time]),
                           venue: params[:venue],
                           host: user.name)
    end
    if event.valid?
      part = Participant.create(user_id: user.id,
                                event_id: event.id,
                                role: "host")
      if part.valid?
        flash[:event_succ] = "You have successfully created #{event.title}"
      else
        event.delete
        flash[:event_fail] = "You have failed to create #{event.title}:("
      end
    else
      flash[:event_fail] = "You have failed to create #{event.title}:("
    end
    redirect_to root_url
  end

  def update
    @event = Event.find(params[:id])
    if !@event.isHost? session[:user_id]
      flash[:event_fail] = "You cannot edit this event:("
    else
      if(params[:usemap] == "true")
        event = @event.update(title: params[:title],
                             summary: params[:summary],
                             description: params[:description],
                             time: makeDate(params[:date], params[:time]),
                             venue: params[:venue],
                             lat: params[:map_lat],
                             lng: params[:map_lng])
      else
        event = @event.update(title: params[:title],
                             summary: params[:summary],
                             description: params[:description],
                             time: makeDate(params[:date], params[:time]),
                             venue: params[:venue])
      end
      if event
        flash[:event_succ] = "You have successfully updated #{@event.title}"
      else
        flash[:event_fail] = "You have failed to update #{@event.title}:("
      end
    end
    redirect_to events_myevents_url
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:event_succ] = "You have successfully deleted #{@event.title}"
    else
      flash[:event_fail] = "You have failed to delete #{@event.title}:("
    end
    redirect_to events_myevents_url
  end

  def join
    user = current_user
    if Event.find(params[:id]).users.include?(user)
      flash[:event_fail] = "You have already joined this event^.^"
    else
      part = Participant.create(user_id: user.id,
                                event_id: params[:id])
      if part.valid?
        flash[:event_succ] = "You have successfully joined:)"
      else
        flash[:event_fail] = "You have failed to join"
      end
    end
    redirect_to event_path(params[:id])
  end

  def quit
    user = current_user
    event = Event.find(params[:id])
    if event.isHost?(user) || !event.isParticipant?(user)
      flash[:event_fail] = "You cannot quit your own event. You can delete it under the Manage Tab"
    else
      part = event.participants.where("user_id = ?", user.id)
      if part.first.delete
        flash[:event_succ] = "You have quit #{event.title}"
      else
        flash[:event_fail] = "You have failed to quit #{event.title}"
      end
    end
    redirect_to root_url
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
