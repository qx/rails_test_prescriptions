#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "a project with no tasks is done" do
    project = Project.new
    assert(project.done?)
  end

  test "a project with an incomplete task is not done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
  end

  #
  test "a project is only done if all its tasks are done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
    task.mark_completed
    assert(project.done?)
  end

  test "a project with no completed tasks projects correctly" do
    project = Project.new
    assert_equal(0, project.completed_velocity)
    assert_equal(0, project.current_rate)
    assert(project.projected_days_remaining.nan?)
    refute(project.on_schedule?)
  end

  #
  test "let's stub an object" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name)      
    assert_nil(project.name)  
  end
  #

  #
  test "let's stub an object again" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name).returns("Fred")
    assert_equal("Fred", project.name)
  end
  #

#
  test "let's stub a class" do
    Project.stubs(:find).returns(Project.new(:name => "Project Greenlight"))
    project = Project.find(1)
    assert_equal("Project Greenlight", project.name)
  end
#

#
  test "stub with multiple returns" do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1, 2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end
#

#
  test "let's mock an object" do
    mock_project = Project.new(:name => "Project Greenlight")
    mock_project.expects(:name).returns("Fred")
    assert_equal("Fred", mock_project.name)
  end
#


end
