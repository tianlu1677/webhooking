# frozen_string_literal: true

class RunScheduleWorker
  include Sidekiq::Worker
  sidekiq_options queue: :schedule, retry: 1, backtrace: true

  def perform(schedule_id)
    schedule = Schedule.find_by(id: schedule_id)
    return if schedule.blank?

    return if schedule.disable?

    schedule.run
  end
end
