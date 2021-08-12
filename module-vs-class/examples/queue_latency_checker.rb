module QueueLatencyChecker
  def queue_full?(queue)
    return false unless queue_max_latency(queue).present?
    return false unless queue_max_size(queue).present?

    (latency(queue) > queue_max_latency(queue)) || (queue_size(queue) > queue_max_size(queue))
  end

  def latency(queue)
    queue(queue).latency
  end

  def queue_size(queue)
    queue(queue).size
  end

  def queue(queue)
    Sidekiq::Queue.new(queue)
  end

  def queue_max_latency(queue)
    Settings.queue_max_latency[queue]
  end

  def queue_max_size(queue)
    Settings.queue_max_size[queue]
  end
end

