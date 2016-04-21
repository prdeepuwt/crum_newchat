require 'test_helper'

class TimeTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_table = time_tables(:one)
  end

  test "should get index" do
    get time_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_time_table_url
    assert_response :success
  end

  test "should create time_table" do
    assert_difference('TimeTable.count') do
      post time_tables_url, params: { time_table: { description: @time_table.description, end: @time_table.end, privacy: @time_table.privacy, start: @time_table.start, title: @time_table.title, user_id: @time_table.user_id } }
    end

    assert_redirected_to time_table_path(TimeTable.last)
  end

  test "should show time_table" do
    get time_table_url(@time_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_table_url(@time_table)
    assert_response :success
  end

  test "should update time_table" do
    patch time_table_url(@time_table), params: { time_table: { description: @time_table.description, end: @time_table.end, privacy: @time_table.privacy, start: @time_table.start, title: @time_table.title, user_id: @time_table.user_id } }
    assert_redirected_to time_table_path(@time_table)
  end

  test "should destroy time_table" do
    assert_difference('TimeTable.count', -1) do
      delete time_table_url(@time_table)
    end

    assert_redirected_to time_tables_path
  end
end
