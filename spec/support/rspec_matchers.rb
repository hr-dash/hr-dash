RSpec::Matchers.define :schedule_rake do |task|
  match do |whenever|
    jobs = whenever.instance_variable_get('@jobs')
    key = @doration.is_a?(ActiveSupport::Duration) ? @duration.to_i : @duration

    if jobs.key?(key)
      jobs[key].any? do |job|
        options = job.instance_variable_get('@options')
        options[:task] == task && (@time.present? ? job.at == @time : true)
      end
    else
      false
    end
  end

  chain :every do |duration|
    @duration = duration
  end

  chain :at do |time|
    @time = time
  end
end
