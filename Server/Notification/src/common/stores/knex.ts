import path from "path";

import { DateTime } from "luxon";
import { types } from "pg";
import Knex from "knex";
import Objection from "objection";

import { config } from "../config";
import {
  inDevelopmentEnv,
  forceMigrate as defaultForceMigrate,
  forceSeed
} from "../utils/env";

// fix parsing `date` columns
const DATE_OID = 1082;
types.setTypeParser(DATE_OID, (isoDateString: string) =>
  // TODO: this is not very reliable, figure something out
  DateTime.fromISO(isoDateString, { zone: "utc" }).toJSDate()
);
// format `time` columns as 'HH:mm' for consistensy
const TIME_OID = 1083;
types.setTypeParser(
  TIME_OID,
  (isoTimeString: string) =>
    /* eslint-disable no-magic-numbers */
    isoTimeString.length === 8 ? isoTimeString.substring(0, 5) : isoTimeString
  /* eslint-enable no-magic-numbers */
);
const BIG_INT_OID = 20;
// convert 'bigint' from string to number
types.setTypeParser(BIG_INT_OID, (bigIntValue: string) =>
  // TODO: this is not very reliable, figure something out
  Number(bigIntValue)
);
const INTERVAL_OID = 1186;
// override interval parser to remain string, not PostgresInterval object
types.setTypeParser(INTERVAL_OID, (intervalValue: string) => intervalValue);

export const knex = Knex({
  client: "pg",
  pool: { min: 0, max: 20 },
  connection: config.postgres,
  migrations: {
    directory: path.resolve(__dirname, "../../../migrations")
  },
  seeds: {
    directory: path.resolve(__dirname, "../../../seeds")
  }
});

Objection.Model.knex(knex);

export const ensureKnexConnection = async (
  {
    migrateAndSeedIfNecessary,
    forceMigrate
  }: {
    migrateAndSeedIfNecessary?: boolean;
    forceMigrate?: boolean;
  } = { forceMigrate: defaultForceMigrate }
) => {
  // wait for connection from Postgres
  await knex.client.acquireRawConnection();

  // abort if not in development or no migrating/seeding is neceessary
  if (!(inDevelopmentEnv && migrateAndSeedIfNecessary)) return;

  try {
    // run all migrations if necessary
    if (forceMigrate && inDevelopmentEnv) {
      await knex.schema.raw(`
        drop schema public cascade;
        create schema public;
      `);
    }

    const [, migrationsLog]: [
      number,
      readonly string[]
    ] = await knex.migrate.latest().catch(err => {
      // some errors imply that migrations have already been run
      if (!err.message.includes("already exists")) {
        throw err;
      }

      return [0, []];
    });
    const migrationsRun = migrationsLog.length !== 0;
    if (migrationsRun) {
      console.info(
        // prettier-ignore
        `Run ${migrationsLog.length} migrations ${`\n${migrationsLog.join('\n')}`}`
      );
    }

    if (inDevelopmentEnv && (migrationsRun || forceSeed)) {
      // run all seeds if necessary
      const [seedsLog]: [readonly string[]] = await knex.seed.run();
      const seedsRun = seedsLog.length !== 0;
      if (seedsRun) {
        console.info(
          `Ran ${seedsLog.length} seed files ${`\n${seedsLog.join("\n")}`}`
        );
      }
    }
  } catch (err) {
    console.error(err.stack);
  }
};
