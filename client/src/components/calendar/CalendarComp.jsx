import React from 'react'
import "./Calendar.css";
import { Calendar } from "react-multi-date-picker";

export default function CalendarComp() {
  return (
    <div className="_calendar_ctr">
      <Calendar range className="mt-3 _details_calendar" />
    </div>
  );
}
