import { bullQueue } from "./common/stores/redis";
import TelegramBot from "node-telegram-bot-api";
import Bull from "bull";
import { config } from "./common/config";

export const startQueueProcessing = () => {
  const bot = new TelegramBot(config.telegram.botToken, { polling: true });

  bullQueue.process("messages:telegram", (job: Bull.Job<any>) => {
    bot.sendMessage(config.telegram.chatId, JSON.stringify(job.data));
    // Telegram.setToken(config.telegram.botToken);
    // Telegram.setRecipient(config.telegram.chatId);
    // Telegram.setMessage(JSON.stringify(job.data));
    // Telegram.send();
  });
};
