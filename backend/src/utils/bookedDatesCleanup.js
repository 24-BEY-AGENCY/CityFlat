import cron from "node-cron";
import appartDb from "../models/appartment.model.js";
import moment from "moment";

const bookedDatesCleanup = () => {
    

    // run the cron job every day at midnight
cron.schedule('0 0 * * *', async () => {
    // get all the apartments
    const apartments = await appartDb.find();
  
    // loop through each apartment
    for (const apartment of apartments) {
      // filter out the booked dates that have already passed
      apartment.bookedDates = apartment.bookedDates.filter(dateRange => moment(dateRange.end).isSameOrAfter(moment(), 'day'));
  
      // save the updated apartment to the database
      await apartment.save();
    }
  });
  };
  
  export default bookedDatesCleanup;