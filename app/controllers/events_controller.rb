class EventsController < ApplicationController
  def index
    @events = Event.all();
  end

  #shows a single event
  def show
    @event = Event.find_by_id(params[:id]);
  end
end
