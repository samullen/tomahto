module Tomahto
#   class Set
#     def initialize
#     end
# 
#     def start
#       Pomodoro.run
#     end
#   end

  class Pomodoro
    def initialize(config={})
      @activity_length = config[:activity_length] || 25
      @break_length    = config[:break_length] || 5
      @iterations      = config[:iterations] || 4
      @sleep_length    = config[:sleep_length] || 1
    end

    def run
      @iterations.times do 
        progress "Activity", @activity_length
        notify "Tomahto: Iteration Complete!", "Take a short break and remember to add a mark to your activity."
        progress "Break", @break_length
        notify "Tomahto: Break's over!", "On to the next pomodoro."
      end
    end

    protected

    def progress(label, minutes)
      1.upto(minutes * 60) do |second|
        display_progress(label, minutes, second)
        Kernel.sleep 1
      end
      puts "\n"
    end

    def display_progress(label, minutes, second)
      total_seconds_left = minutes * 60 - second
      progress_past      = second / 60
      progress_left      = minutes - progress_past
      minutes_left       = total_seconds_left / 60
      seconds_left       = total_seconds_left % 60
      color = "\e[0;32m"

      if minutes_left < 2
        color = "\e[0;31m"
      elsif minutes_left < 5
        color = "\e[1;33m"
      end

      printf "\r%20s - #{color}%s%s\e[m - %.2d:%.2d", label, "#" * progress_past, "." * progress_left, minutes_left, seconds_left
    end

    def notify(summary, message)
      puts message
      Kernel.system("notify-send -t 500 \"#{summary}\" \"#{message}\"")
    end
  end

#   class Activity
#   end
end
