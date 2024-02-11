import React from "react";
import "./CustomersContent.css";

export default function CustomersContent() {
  return (
    <>
      <div className="container-fluid py-4">
        <h1 className="h3 mb-0 text-start">Customers (16)</h1>
      </div>
      <div className="row">
        <div className="col-lg-12 mb-4">
          <div className="row">
            <div className="col-lg-8 booking_inputs">
              <input placeholder="search" />
            </div>
            <div className="col-lg-4  booking_inputs">
              <input type="date" />
            </div>
          </div>
        </div>
      </div>
      <section className="tables scrollable-container">
        <div className="table__wrapper scrollable-container">
          <table className="customers_table">
            <thead className="table__header">
              <tr>
                <td>name</td>
                <td>email</td>
                <td>Phone Num.</td>
                <td>Account</td>
              </tr>
            </thead>
            <tbody className="table__body">
              <tr>
                <td>
                  <svg
                    width="40"
                    height="48"
                    viewBox="0 0 48 48"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    style={{ paddingRight: 5 }}
                  >
                    <rect
                      width="48"
                      height="48"
                      rx="12.1951"
                      fill="white"
                      fill-opacity="0.08"
                    />
                    <path
                      d="M24 9C20.93 9 18.4184 11.5379 18.4184 14.6375C18.4184 17.7371 20.9311 20.275 24 20.275C27.0689 20.275 29.5816 17.7359 29.5816 14.6375C29.5827 11.5379 27.0689 9 24 9ZM11 33.8538C10.9977 34.4885 11.5064 35.0023 12.1349 35H35.8651C36.4936 35.0023 37.0023 34.4874 37 33.8538C37 27.6032 32.664 22.3573 26.853 21.0433C26.4268 20.9428 25.9815 21.1004 25.7091 21.4474L24.1153 23.5036L22.5306 21.4132C22.3237 21.1346 22.0004 20.9679 21.5347 20.9714C15.4727 22.1986 11 27.5096 11 33.8538Z"
                      fill="#0DB254"
                    />
                  </svg>
                  Sidi Youssef
                </td>
                <td>city-flat-customer@24bey.tn</td>
                <td>999-999-999-99-99</td>
                <td className="d-flex align-items-center gap-2">
                  <div class="close-btn"></div>
                  <div class="customer_slider">
                    <input
                      type="checkbox"
                      name="slider"
                      class="slider-checkbox"
                      id="sliderSwitch"
                    />
                    <label class="slider-label" for="sliderSwitch">
                      <span class="slider-inner"></span>
                      <span class="slider-circle"></span>
                    </label>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
}
