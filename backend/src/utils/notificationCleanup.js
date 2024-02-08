import cron from "node-cron";
import Notification from "../models/notification.model.js";

const startNotificationCleanup = () => {
  cron.schedule("0 0 * * *", async () => {
    try {
      // Calculate the date 5 days ago
      const fiveDaysAgo = new Date();
      fiveDaysAgo.setDate(fiveDaysAgo.getDate() - 5);

      // Find and delete notifications that were read more than 5 days ago
      const result = await Notification.deleteMany({ read: true, readAt: { $lt: fiveDaysAgo } });

      console.log(`Deleted ${result.deletedCount} notifications`);
    } catch (error) {
      console.error(error);
    }
  });
};

export default startNotificationCleanup;