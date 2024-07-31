# == Schema Information
#
# Table name: schedules
#
#  id                 :bigint           not null, primary key
#  name               :string
#  interval           :string
#  request_url        :string
#  request_method     :string
#  request_body       :text
#  request_headers    :jsonb
#  request_status_min :string
#  request_status_max :string
#  user_id            :integer
#  cron               :string
#  last_run_at        :datetime
#  last_run_status    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'web_request'

class Schedule < ApplicationRecord
  has_many :schedule_logs, dependent: :destroy

  after_save :schedule_job_update

  def job_name
    "schedule-#{id}"
  end

  def run
    result = make_request
    success = result[:status]
    update(last_run_at: Time.current, last_run_status: success)

    record_log(result)
    result
  end

  def make_request
    WebRequest.new(request_method:, request_url:, request_body:, request_headers:, timeout: 30).execute
  end

  def record_log(result)
    success = result[:status]
    if success
      attrs = result.slice(:response_status, :response_body, :response_headers, :request)
      schedule_logs.create(attrs)
    else
      schedule_logs.create(status: 600, error: result[:error_message])
    end
  end

  private

  def schedule_job_update
    self.class.refresh_schedule_job(self)
  end

  class << self
    def refresh_schedule_job(schedule)
      cron_value = schedule.cron.presence || schedule.interval

      delete_schedule_job!(schedule)
      return if schedule.disable?

      Sidekiq::Cron::Job.create(
        name: schedule.job_name,
        cron: cron_value,
        class: 'RunScheduleWorker',
        args: schedule.id
      )
    end

    def delete_schedule_job!(schedule)
      job = Sidekiq::Cron::Job.find(schedule.job_name)
      job.destroy if job.present?
    end
  end
end
