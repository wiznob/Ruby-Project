require "test_helper"

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calendar = calendars(:one)
  end

  test "should get index" do
    get calendars_url
    assert_response :success
  end

  test "should get new" do
    get new_calendar_url
    assert_response :success
  end
    # new tests start
    test "should NOT accept incomplete records" do
      post calendars_url, params: { calendar: { title: "", description: @calendar.description, start_time: @calendar.start_time, end_time: @calendar.end_time } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept empty description" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: "", start_time: @calendar.start_time, end_time: @calendar.end_time } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept empty start time" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: nil, end_time: @calendar.end_time } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept empty end time records" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: @calendar.start_time, end_time: nil } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept start time in year 2023 or older" do# Code refrence for time: https://docs.ruby-lang.org/en/master/Time.html
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: Time.new(2023, 12, 31, 10, 0, 0), end_time: @calendar.end_time } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept end time in year 2023 or older" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: @calendar.start_time, end_time: Time.new(2023, 12, 31, 10, 0, 0) } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept start time outside business hours" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: Time.new(2024, 1, 1, 7, 0, 0), end_time: @calendar.end_time } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end

    test "should NOT accept end time outside business hours" do
      post calendars_url, params: { calendar: { title: @calendar.title, description: @calendar.description, start_time: @calendar.start_time, end_time: Time.new(2024, 1, 1, 22, 0, 0) } }
      assert (400...500).include?(response.code.to_i)   # not ok
    end
  # end of my tests
  test "should create calendar" do
    assert_difference("Calendar.count") do
      post calendars_url, params: { calendar: { description: @calendar.description, end_time: @calendar.end_time, start_time: @calendar.start_time, title: @calendar.title } }
    end

    assert_redirected_to calendar_url(Calendar.last)
  end

  test "should show calendar" do
    get calendar_url(@calendar)
    assert_response :success
  end

  test "should get edit" do
    get edit_calendar_url(@calendar)
    assert_response :success
  end

  test "should update calendar" do
    patch calendar_url(@calendar), params: { calendar: { description: @calendar.description, end_time: @calendar.end_time, start_time: @calendar.start_time, title: @calendar.title } }
    assert_redirected_to calendar_url(@calendar)
  end

  test "should destroy calendar" do
    assert_difference("Calendar.count", -1) do
      delete calendar_url(@calendar)
    end

    assert_redirected_to calendars_url
  end
end
