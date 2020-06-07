import HttpError from "http-errors";

import { is } from "./data-types";

export const env = new Proxy(process.env, {
  get(_, key: string): string {
    const value = process.env[key];
    if (!is.nonEmptyString(value)) {
      throw new HttpError.InternalServerError(
        `Missing ${key} environment variable`
      );
    }

    return value;
  }
}) as { [key: string]: string };

type Environment = "test" | "development" | "staging" | "production";

export const environment = ((): Environment => {
  if (process.env.NODE_ENV === "test") return "test";
  if (
    process.env.NODE_ENV === "production" &&
    is.nonEmptyString(process.env.API_LIVE_URL) &&
    !process.env.API_LIVE_URL.includes("staging")
  ) {
    return "production";
  }
  if (
    process.env.NODE_ENV !== "development" &&
    is.nonEmptyString(process.env.API_LIVE_URL) &&
    process.env.API_LIVE_URL.includes("staging")
  ) {
    return "staging";
  }

  return "development";
})();

export const inDevelopmentEnv = environment === "development";
export const inProductionEnv = environment === "production";
export const inTestEnv = environment === "test";

export const inStagingDeployment = environment === "staging";
export const inProductionDeployment = environment === "production";

export const loadTesting = is.nonEmptyString(process.env.LOAD_TESTING);
export const forceMigrate = is.nonEmptyString(process.env.FORCE_MIGRATE);
export const forceSeed = is.nonEmptyString(process.env.FORCE_SEED);
