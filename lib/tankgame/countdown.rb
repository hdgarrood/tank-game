require 'time'
require 'gosu'

module TankGame
  class Countdown
    # starts the countdown timer with +time+ milliseconds on
    # the clock.
    def start(time)
      @time = time
      @start_time = Gosu::milliseconds
      return self
    end

    # returns time until end of countdown, in milliseconds
    def time_remaining
      delta = Gosu::milliseconds - @start_time
      [@time - delta, 0].max
    end

    def finished?
      time_remaining == 0
    end
  end
end
