require 'time'
require 'gosu'

module TankGame
  # TODO: check that Gosu::milliseconds won't overflow and bugger
  # everything up.
  class Countdown
    def initialize
      @started = false
    end

    # starts the countdown timer with +time+ milliseconds on the clock.
    def start(time)
      @started = true
      @time = time
      @start_time = Gosu::milliseconds
      return self
    end

    # returns time until end of countdown, in milliseconds
    def time_remaining
      if @started
        delta = Gosu::milliseconds - @start_time
        [@time - delta, 0].max
      else
        nil
      end
    end

    def finished?
      time_remaining == 0
    end

    def started?
      @started
    end
  end
end
