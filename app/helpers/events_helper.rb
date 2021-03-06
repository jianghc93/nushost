module EventsHelper
  def menu_load option
    @option1 = ""
    @option2 = ""
    @option3 = ""

    case option
      when 0
        @option1 = "active"
      when 1
        @option2 = "active"
      when 2
        @option3 = "active"
    end

    render 'menunav'
  end

  #choose which btn to render
  def load_btn option, event
    case option
      when "info"
        render partial: 'infoBtn', locals: { event_id: event.id }
      when "join"
        if event.isParticipant?(session[:user_id])
          render partial: 'quitBtn', locals: { event_id: event.id }
        else
          render partial: 'joinBtn', locals: { event_id: event.id }
        end
      when "edit"
        render partial: 'editBtn', locals: { event_id: event.id }
      when "delete"
        render partial: 'deleteBtn', locals: { event_id: event.id }
    end
  end

  def load_form event
    if event == nil
      #do nothing
    else
      @title = event.title
      @summary = event.summary
      @description = event.description
      @date = event.time.strftime("%d-%m-%Y")
      @time = event.time.strftime("%I:%M %p")
      @venue = event.venue
    end
    render 'formfields'
  end

  def load_search_results events
    if events.blank?
      render plain: "Sorry there are no events that match your search"
    else
      render 'tableofevents'
    end
  end

end
