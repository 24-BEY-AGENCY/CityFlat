import React from "react";
import "./DashContent.css";

export default function DashContent() {
  return (
    <>
      <div className="container-fluid py-4">
        <div className="mb-4">
          <h1 className="h3 mb-0 text-start">Dashboard</h1>
        </div>
        <div className="row">
          <div className="col-xl-4 col-md-6 mb-4">
            <div
              className="card border-left-success shadow h-100 py-2"
              id="card-small"
            >
              <div className="card-body">
                <div className="row no-gutters align-items-center">
                  <div className="col-8 mr-2">
                    <div className="_date mb-1">
                      Earnings <small>(Annual)</small>
                    </div>
                    <div className="_number mt-3">$84,326</div>
                    <div className="_gold_text ">$84,326</div>
                  </div>
                  <div className="col-4 mr-2">
                    <div className="text-xs font-weight-bold text-muted text-uppercase mb-1">
                      <svg
                        width="82"
                        height="82"
                        viewBox="0 0 82 82"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <rect
                          width="82"
                          height="82"
                          rx="25"
                          fill="white"
                          fillOpacity="0.08"
                        />
                        <path
                          d="M58.1012 18.6045H26.899C20.8893 18.6045 16 23.4937 16 29.5034C16 35.5422 20.9401 40.4024 26.8339 40.4024H31.7292V31.863C31.7292 28.0387 34.8404 24.9274 38.6645 24.9274H38.6797C42.4958 24.9356 45.6003 28.0469 45.6003 31.863V40.4024H58.1012C64.1109 40.4024 69 35.5131 69 29.5034C69 23.4937 64.1109 18.6045 58.1012 18.6045ZM61.1853 27.9836L54.9744 34.1946C54.3681 34.801 53.3849 34.8011 52.7785 34.1946L49.673 31.0891C49.0666 30.4827 49.0666 29.4996 49.673 28.8932C50.2793 28.2868 51.2625 28.2868 51.8689 28.8932L53.8765 30.9007L58.9895 25.7878C59.5958 25.1814 60.579 25.1814 61.1854 25.7878C61.7917 26.3941 61.7917 27.3773 61.1853 27.9836Z"
                          fill="url(#paint0_linear_0_1)"
                        />
                        <path
                          d="M52.4907 44.7721L42.4949 43.7331V31.8628C42.4949 29.7507 40.7851 28.0373 38.673 28.0327C36.5546 28.0282 34.8348 29.7443 34.8348 31.8628V51.7294H34.8L31.0193 48.5722C29.4246 47.2406 27.045 47.4902 25.7614 49.1238C24.5305 50.6904 24.7682 52.9517 26.2978 54.2282L33.9718 60.6318H56.5729V49.3945C56.5729 47.0445 54.8226 45.0626 52.4907 44.7721Z"
                          fill="url(#paint1_linear_0_1)"
                        />
                        <path
                          d="M34.8345 66.8428C34.8345 67.7003 35.5297 68.3955 36.3872 68.3955H55.02C55.8775 68.3955 56.5728 67.7003 56.5728 66.8428V63.7373H34.8345V66.8428Z"
                          fill="url(#paint2_linear_0_1)"
                        />
                        <defs>
                          <linearGradient
                            id="paint0_linear_0_1"
                            x1="33.2826"
                            y1="17.3977"
                            x2="38.0629"
                            y2="43.2589"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stopColor="#AE7D36" />
                            <stop offset="1" stopColor="#F5F5B2" />
                          </linearGradient>
                          <linearGradient
                            id="paint1_linear_0_1"
                            x1="35.2781"
                            y1="26.2279"
                            x2="50.5418"
                            y2="59.1479"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stopColor="#AE7D36" />
                            <stop offset="1" stopColor="#F5F5B2" />
                          </linearGradient>
                          <linearGradient
                            id="paint2_linear_0_1"
                            x1="41.923"
                            y1="63.4794"
                            x2="42.4684"
                            y2="69.1422"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stopColor="#AE7D36" />
                            <stop offset="1" stopColor="#F5F5B2" />
                          </linearGradient>
                        </defs>
                      </svg>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="col-xl-4 col-md-6 mb-4">
            <div
              className="card border-left-warning shadow h-100 py-2"
              id="card-small"
            >
              <div className="card-body">
                <div className="row no-gutters align-items-center">
                  <div className="col-8 mr-2">
                    <div className="_date mb-1">
                      Earnings <small>(Annual)</small>
                    </div>
                    <div className="_number mt-3">$84,326</div>
                    <div className="_gold_text ">$84,326</div>
                  </div>
                  <div className="col-4 mr-2">
                    <div className="text-xs font-weight-bold text-muted text-uppercase mb-1">
                      <svg
                        width="82"
                        height="82"
                        viewBox="0 0 82 82"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <rect
                          width="82"
                          height="82"
                          rx="25"
                          fill="white"
                          fillOpacity="0.08"
                        />
                        <g clipPath="url(#clip0_0_1)">
                          <path
                            d="M20 19V23.2H22.1V61H36.7999V52.6H45.2V61H59.8999V23.2H61.9999V19H20ZM32.6 48.4H28.4V44.2H32.6V48.4ZM32.6 40H28.4V35.7999H32.6V40ZM32.6 31.6H28.4V27.4H32.6V31.6ZM43.1 48.4H38.9V44.2H43.1V48.4ZM43.1 40H38.9V35.7999H43.1V40ZM43.1 31.6H38.9V27.4H43.1V31.6ZM53.5999 48.4H49.3999V44.2H53.5999V48.4ZM53.5999 40H49.3999V35.7999H53.5999V40ZM53.5999 31.6H49.3999V27.4H53.5999V31.6Z"
                            fill="url(#paint0_linear_0_1)"
                          />
                        </g>
                        <defs>
                          <linearGradient
                            id="paint0_linear_0_1"
                            x1="54.2096"
                            y1="51.7805"
                            x2="28.6007"
                            y2="26.3782"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stopColor="#07D25F" />
                            <stop offset="1" stopColor="#028139" />
                          </linearGradient>
                          <clipPath id="clip0_0_1">
                            <rect
                              width="42"
                              height="42"
                              fill="white"
                              transform="translate(20 19)"
                            />
                          </clipPath>
                        </defs>
                      </svg>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="col-xl-4 col-md-6 mb-4">
            <div
              className="card border-left-warning shadow h-100 py-2"
              id="card-small"
            >
              <div className="card-body">
                <div className="row no-gutters align-items-center">
                  <div className="col-8 mr-2">
                    <div className="_date mb-1">
                      Earnings <small>(Annual)</small>
                    </div>
                    <div className="_number mt-3">$84,326</div>
                    <div className="_gold_text ">$84,326</div>
                  </div>
                  <div className="col-4 mr-2">
                    <div className="text-xs font-weight-bold text-muted text-uppercase mb-1">
                      <svg
                        width="82"
                        height="82"
                        viewBox="0 0 82 82"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <rect
                          width="82"
                          height="82"
                          rx="25"
                          fill="white"
                          fillOpacity="0.08"
                        />
                        <g clipPath="url(#clip0_0_1)">
                          <path
                            d="M20 19V23.2H22.1V61H36.7999V52.6H45.2V61H59.8999V23.2H61.9999V19H20ZM32.6 48.4H28.4V44.2H32.6V48.4ZM32.6 40H28.4V35.7999H32.6V40ZM32.6 31.6H28.4V27.4H32.6V31.6ZM43.1 48.4H38.9V44.2H43.1V48.4ZM43.1 40H38.9V35.7999H43.1V40ZM43.1 31.6H38.9V27.4H43.1V31.6ZM53.5999 48.4H49.3999V44.2H53.5999V48.4ZM53.5999 40H49.3999V35.7999H53.5999V40ZM53.5999 31.6H49.3999V27.4H53.5999V31.6Z"
                            fill="url(#paint0_linear_0_1)"
                          />
                        </g>
                        <defs>
                          <linearGradient
                            id="paint0_linear_0_1"
                            x1="54.2096"
                            y1="51.7805"
                            x2="28.6007"
                            y2="26.3782"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stopColor="#07D25F" />
                            <stop offset="1" stopColor="#028139" />
                          </linearGradient>
                          <clipPath id="clip0_0_1">
                            <rect
                              width="42"
                              height="42"
                              fill="white"
                              transform="translate(20 19)"
                            />
                          </clipPath>
                        </defs>
                      </svg>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-lg-12 mb-4">
            <div className="row">
              <div className="col-lg-6 mb-4">
                <div
                  className="card bg-primary text-white shadow"
                  id="card-long"
                >
                  <div className="card-body">Primary</div>
                </div>
              </div>
              <div className="col-lg-6 mb-4">
                <div
                  className="card bg-success text-white shadow"
                  id="card-long"
                >
                  <div className="card-body">Success</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
