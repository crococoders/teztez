import Redis from "ioredis";
import Bull from "bull";

import { config } from "../config";

export const redis = new Redis({
  host: config.redis.host,
  port: config.redis.port,
  password: config.redis.password
});

const clientRedis = redis;
const subscriberRedis = redis.duplicate();

const defaultJobOptions = {
  removeOnComplete: true,
  removeOnFail: false
};

const limiter = {
  max: 10000,
  duration: 1000,
  bounceBack: false
};

const settings = {
  lockDuration: 600000, // Key expiration time for job locks.
  stalledInterval: 5000, // How often check for stalled jobs (use 0 for never checking).
  maxStalledCount: 2, // Max amount of times a stalled job will be re-processed.
  guardInterval: 5000, // Poll interval for delayed jobs and added jobs.
  retryProcessDelay: 30000, // delay before processing next job in case of internal error.
  drainDelay: 5 // A timeout for when the queue is in drained state (empty waiting for jobs).
};

export const bullQueue = new Bull("message_queue", {
  createClient: type => {
    switch (type) {
      case "client":
        return clientRedis;
      case "subscriber":
        return subscriberRedis;
      default:
        return redis.duplicate();
    }
  },
  defaultJobOptions,
  settings,
  limiter
});
