# frozen_string_literal: true

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    super
    @user = users(:ironman)
    @subscription = subscriptions(:subscription1)
  end

  test 'subscription is valid' do
    assert_predicate @subscription, :valid?
  end

  test 'start_at and end_at cannot be nil' do
    @subscription.start_at = nil
    assert_not_predicate @subscription, :valid?

    @subscription.reload

    @subscription.end_at = nil
    assert_not_predicate @subscription, :valid?
  end

  test 'end_date is strictly after start_date' do
    @subscription.end_at = @subscription.start_at - 1.month
    assert_not_predicate @subscription, :valid?

    @subscription.end_at = @subscription.start_at
    assert_not_predicate @subscription, :valid?
  end

  # test "cancelled_at can't be changed when not nil" do
  #   subscription = @user.subscriptions.new(start_at: Time.current,
  # end_at: 1.month.from_now, cancelled_at: Time.current)
  #   assert_predicate subscription, :valid?
  #   subscription.save!
  #
  #   subscription.cancelled_at = subscription.cancelled_at + 1.day
  #   assert_not_predicate subscription, :valid?
  #
  #   subscription.cancelled_at = nil
  #   assert_not_predicate subscription, :valid?
  # end
  #
  # test 'cancelled_at can be changed when nil' do
  #   subscription = @user.subscriptions.new(start_at: Time.current, end_at: 1.month.from_now)
  #   subscription.save
  #
  #   subscription.cancelled_at = Time.current
  #   assert_predicate subscription, :valid?
  # end
  #
  # test 'subscription should be destroyed when the user is destroyed' do
  #   assert_difference 'Subscription.count', -1 do
  #     @user.destroy
  #   end
  # end

  # test 'when cancelling a subscription, cancelled_at should be updated' do
  #   freeze_time
  #
  #   @subscription.cancel!
  #   assert_equal Time.current, @subscription.cancelled_at
  # end

  # test 'duration should give months' do
  #   freeze_time
  #
  #   subscription = @user.subscriptions.create(start_at: Time.current, end_at: 8.months.from_now)
  #   subscription.reload
  #   assert_equal 8, subscription.duration
  #
  #   subscription = @user.subscriptions.create(start_at: Time.current, end_at: 13.months.from_now)
  #   subscription.reload
  #   assert_equal 13, subscription.duration
  #
  #   travel_to Time.zone.local(2024, 5, 31)
  #
  #   subscription = @user.subscriptions.create(start_at: Time.current, end_at: 8.months.from_now)
  #   subscription.reload
  #   assert_equal 8, subscription.duration
  #
  #   subscription = @user.subscriptions.create(start_at: Time.current, end_at: 13.months.from_now)
  #   subscription.reload
  #   assert_equal 13, subscription.duration
  # end
end
