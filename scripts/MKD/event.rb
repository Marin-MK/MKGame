module MKD
  class Event
    attr_accessor :id
    attr_accessor :name
    attr_accessor :x
    attr_accessor :y
    attr_accessor :pages
    attr_accessor :settings

    def initialize(id = 0)
      @id = id
      @name = ""
      @x = 0
      @y = 0
      @pages = [Page.new]
      @settings = MKD::Event::Settings.new
    end
  end
end

module MKD
  class Event
    class Settings
      attr_accessor :priority
      attr_accessor :passable
      attr_accessor :can_start_surfing_here
      attr_accessor :reset_position_on_transfer

      def initialize
        @priority = 1
        @passable = true
        @can_start_surfing_here = true
        @reset_position_on_transfer = true
      end
    end
  end
end

module MKD
  class Event
    class Page
      attr_accessor :commands
      attr_accessor :conditions
      attr_accessor :graphic
      attr_accessor :triggers

      def initialize
        @commands = []
        @conditions = []
        @graphic = Graphic.new
        @triggers = [:interaction]
      end
    end
  end
end

module MKD
  class Event
    class Page
      class Graphic
        attr_accessor :type
        attr_accessor :param
        attr_accessor :direction

        def initialize
          @type = 0
          @param = ""
          @direction = 2
        end
      end
    end
  end
end