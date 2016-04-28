#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
RSpec::Matchers.define :have_size do |expected|
  match do |actual|
    size_to_check = @incomplete? actual.remaining_size : actual.total_size
    size_to_check == expected
  end

  description do
    "have tasks totaling #{expected} points"
  end

  failure_message do |actual|
    "expected project #{project.name} to have size #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected project #{project.name} not to have size #{acutal}"
  end

  chain :for_incomplete_tasks_only do
    @incomplete = true
  end
end
