import React from "react";
import "./Cards.css";
import house from "../../assets/homepage_mats/vue-du-modele-maison-3d.png";

export default function Cards() {
  return (
      <div className="material-card" href="/some-article">
        <img className="card-picture" src={house} />
        <div className="card-info">
          <div className="cart-title-rating">
            <h2 className="card-title">Appartement B</h2>
            <span className="card-rating">
              <svg
                width="21"
                height="19"
                viewBox="0 0 21 19"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M10.5 0L12.9787 7.25735H21L14.5106 11.7426L16.9894 19L10.5 14.5147L4.01064 19L6.48936 11.7426L0 7.25735H8.02129L10.5 0Z"
                  fill="#F1AF07"
                />
              </svg>
              4.5
            </span>
          </div>
          <div className="card-location">
            <span className="card-span">
              {" "}
              <svg
                width="12"
                height="12"
                viewBox="0 0 12 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g clipPath="url(#clip0_1_43)">
                  <path
                    d="M5.84864 0.00250112C8.28559 -0.0796255 10.2869 1.87139 10.2869 4.28979C10.2869 7.03441 7.65297 9.02627 6.17668 11.8908C6.10172 12.0363 5.89235 12.0365 5.81714 11.891C4.48162 9.31351 2.19904 7.58514 1.77602 5.10199C1.33803 2.53242 3.24353 0.0903287 5.84864 0.00250112ZM5.99712 6.53679C7.23809 6.53679 8.24412 5.53073 8.24412 4.28979C8.24412 3.04885 7.23806 2.04279 5.99712 2.04279C4.75616 2.04279 3.7501 3.04885 3.7501 4.28979C3.7501 5.53073 4.75616 6.53679 5.99712 6.53679Z"
                    fill="#DEC25F"
                  />
                </g>
                <defs>
                  <clipPath id="clip0_1_43">
                    <rect
                      width="12"
                      height="12"
                      fill="white"
                      transform="matrix(-1 0 0 1 12 0)"
                    />
                  </clipPath>
                </defs>
              </svg>
              Duessldorf, Allegmagne
            </span>
          </div>
        </div>
        <div className="card-price-btn">
          <div className="card-price">
            <p>
              3000 € <span>/ Month</span>
            </p>
          </div>
          <div className="card-btn">
            <button>More +</button>
          </div>
        </div>
      </div>
  );
}
