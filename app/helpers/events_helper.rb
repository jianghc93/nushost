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

  #choose which set of btns to render
  def load_btn option, event_id
    if option == 1
      render partial: 'editDeleteBtn', locals: { event_id: event_id }
    else
      render partial: 'infoJoinBtn', locals: { event_id: event_id }
    end
  end

  def load_form event
    if event == nil
      render 'formfields'
    else
      @title = event.title
      @summary = event.summary
      @description = event.description
      @date = event.time.strftime("%d-%m-%Y")
      @time = event.time.strftime("%I:%M %p")
      @venue = event.venue
      render 'formfields'
    end
  end

  def load_search_results events
    if events.blank?
      render plain: "Sorry there are no events that match your search"
    else
      render 'tableofevents'
    end
  end

end
