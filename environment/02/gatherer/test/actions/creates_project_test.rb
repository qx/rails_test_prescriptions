#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
#
require_relative '../active_record_test_helper'
require_relative '../../app/models/project.rb'
require_relative '../../app/models/task.rb'
require_relative '../../app/actions/creates_project.rb'
#

class CreatesProjectTest < ActiveSupport::TestCase

  test "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    assert_equal "Project Runway", creator.project.name
  end

  test "handles an empty string" do
    creator = CreatesProject.new(name: "Test", task_string: "")
    tasks = creator.convert_string_to_tasks
    assert_equal 0, tasks.size
  end

  test "handles a single string" do
    creator = CreatesProject.new(name: "Test", task_string: "start things")
    tasks = creator.convert_string_to_tasks
    assert_equal 1, tasks.size
    assert_equal "start things", tasks.first.title
    assert_equal 1, tasks.first.size
  end

  test "handles a single string with a size" do
    creator = CreatesProject.new(name: "Test", task_string: "start things:3")
    tasks = creator.convert_string_to_tasks
    assert_equal 1, tasks.size
    assert_equal "start things", tasks.first.title
    assert_equal 3, tasks.first.size
  end

  test "handles multiple tasks" do
    creator = CreatesProject.new(
        name: "Test", task_string: "start things:3\nend things:2")
    tasks = creator.convert_string_to_tasks
    assert_equal 2, tasks.size
  end

  test "saves a project with tasks" do
    creator = CreatesProject.new(name: "Project Runway",
        task_string: "start things:3\nend things:2")
    creator.build.save
    assert_equal 2, creator.project.tasks.size
    refute creator.project.new_record?
  end

  #
  test "adds users to the project" do
    project = Project.new
    user = stub
    project.expects(:add_users).with([user])
    Project.stubs(:new).returns(project)
    creator = CreatesProject.new(name: "Project Runway", users: [user])
    creator.build
  end
  #
end
