# frozen_string_literal: true
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max requests per worker
max_request_min =  3072
max_request_max =  4096
use Unicorn::WorkerKiller::MaxRequests, max_request_min, max_request_max

# Max memory size (RSS) per worker
oom_min = (192 * (1024**2))
oom_max = (256 * (1024**2))
use Unicorn::WorkerKiller::Oom, oom_min, oom_max

run Rails.application
