module Tomahto
  class Pomodoro
    def initialize
    end

    def run
      progress "activity", 25
      progress "break", 5
    end

    protected

    def progress(label, minutes)
      (minutes * 60).times do |second|
        display_progress(label, minutes, second)
        Kernel.sleep 1
      end
    end

    def display_progress(label, minutes, second)
      progress_past = second / 60
      progress_left = minutes - progress_past
      seconds_left = minutes * 60 - second
      minutes_left = seconds_left / 60

      printf "\r%s - %s%s - %.2d:%.2d", label, "#" * progress_past, "." * progress_left, minutes_left, seconds_left % 60
    end
  end

  class Activity
  end
end
