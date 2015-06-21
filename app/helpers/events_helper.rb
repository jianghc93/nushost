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
end
