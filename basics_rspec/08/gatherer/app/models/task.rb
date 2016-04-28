#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class Task

  attr_accessor :size, :completed_at

  def initialize(options = {})
    mark_completed(options[:completed_at]) if options[:completed_at]
    @size = options[:size]
  end

  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
  end

  def complete?
    completed_at.present?
  end

#
  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end
#


  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end

end
