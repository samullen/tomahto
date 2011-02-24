module Tomahto
  class Pomodoro
    def initialize
    end

    def run
      4.times do 
        progress "activity", 25
        notify "Tomahto: Iteration Complete!", "Take a short break and remember to add a mark to your activity."
        progress "break", 5
        notify "Tomahto: Break's over!", "On to the next pomodoro."
      end
      notify "You've completed a set. Take a longer break."
    end

    protected

    def progress(label, minutes)
      1.upto(minutes * 60) do |second|
        display_progress(label, minutes, second)
        Kernel.sleep 1
      end
      print "\n"
    end

    def display_progress(label, minutes, second)
      total_seconds_left = minutes * 60 - second
      progress_past      = second / 60
      progress_left      = minutes - progress_past
      minutes_left       = total_seconds_left / 60
      seconds_left       = total_seconds_left % 60

      printf "\r%20s - %s%s - %.2d:%.2d", label, "#" * progress_past, "." * progress_left, minutes_left, seconds_left
    end

    def notify(summary, message)
      puts message
      system("notify-send -t 500 \"#{summary}\" \"#{message}\"")
    end
  end

  class Activity
  end
end
