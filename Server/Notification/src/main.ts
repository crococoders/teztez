import http from "http";
import express from "express";

// import { ensureKnexConnection } from "./common/stores/knex";
import { config } from "./common/config";
import { startQueueProcessing } from "./worker";

const app = express();

const startWorker = () => {
  startQueueProcessing();
};

const startServer = async () => {
  // await ensureKnexConnection({ migrateAndSeedIfNecessary: true });

  const httpServer = http.createServer(app);
  app.get("/about", (_req, res) => {
    res.send("Marvelous Teztez worker changes");
  });

  startWorker();

  httpServer.listen(config.api.port, () =>
    console.info(`Now running on http://localhost:${config.api.port}`)
  );
};

startServer();
