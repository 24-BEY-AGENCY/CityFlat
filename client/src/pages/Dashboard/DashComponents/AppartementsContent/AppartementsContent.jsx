import React from "react";
import "./AppartementsContent.css";

export default function AppartementsContent() {
  return (
    <>
      <div className="container-fluid py-4">
        <h1 className="h3 mb-0 text-start">Appartements (4)</h1>
      </div>
      <ul class="app_cards">
        <li class="app_cards_item">
          <div class="add_app_card">
            <div class="add_app_card_content d-flex align-items-center justify-content-center flex-column">
              <svg
                width="70"
                height="70"
                viewBox="0 0 70 70"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <rect
                  width="70"
                  height="70"
                  rx="20"
                  fill="white"
                  fill-opacity="0.08"
                />
                <rect
                  x="0.5"
                  y="0.5"
                  width="69"
                  height="69"
                  rx="19.5"
                  stroke="white"
                  stroke-opacity="0.16"
                />
                <g clip-path="url(#clip0_0_1)">
                  <path
                    d="M35.0198 36.4046L35.0198 48.7281H32.9802L32.9802 36.4046L20.6567 36.4046L20.6567 34.365L32.9802 34.365L32.9802 22.0414H35.0198L35.0198 34.365L47.3433 34.365L47.3433 36.4046L35.0198 36.4046Z"
                    fill="white"
                  />
                </g>
                <defs>
                  <clipPath id="clip0_0_1">
                    <rect
                      width="26"
                      height="26"
                      fill="white"
                      transform="translate(34 17) rotate(45)"
                    />
                  </clipPath>
                </defs>
              </svg>
            </div>
          </div>
        </li>
        <li class="app_cards_item">
          <div class="app_card">
            <div class="app_card_image">
              <img src="//placehold.it/500x300&text=%20" />
            </div>

            <div class="app_card_content">
              <div class="app_card_heading d-flex justify-content-between">
                <span>text</span>
                <span>text</span>
              </div>
              <p>Lorem ipsum dolor sit amet</p>
              <div class="app_card_heading d-flex justify-content-between">
                <div className="d-flex align-items-center gap-2">
                  <span>text</span>
                  <div className="d-flex flex-column">
                    <span>text</span>
                    <span>text</span>
                  </div>
                </div>
                <div className="d-flex align-items-center gap-2">
                  <span>text</span>
                  <div className="d-flex flex-column">
                    <span>text</span>
                    <span>text</span>
                  </div>
                </div>
              </div>
              <div class="app_card_heading d-flex justify-content-between">
                <span>text</span>
                <div className="d-flex gap-2">
                  <span>text</span>
                  <span>text</span>
                </div>
              </div>
            </div>
          </div>
        </li>
        <li class="app_cards_item">
          <div class="app_card">
            <div class="app_card_image">
              <img src="//placehold.it/500x300&text=%20" />
            </div>

            <div class="app_card_content">
              <h2 class="app_card_heading"></h2>
              <p></p>
              <a href="#" class="app_card_button"></a>
            </div>
          </div>
        </li>
        <li class="app_cards_item">
          <div class="app_card">
            <div class="app_card_image">
              <img src="//placehold.it/500x300&text=%20" />
            </div>

            <div class="app_card_content">
              <h2 class="app_card_heading"></h2>
              <p></p>
              <a href="#" class="app_card_button"></a>
            </div>
          </div>
        </li>
        <li class="app_cards_item">
          <div class="app_card">
            <div class="app_card_image">
              <img src="//placehold.it/500x300&text=%20" />
            </div>

            <div class="app_card_content">
              <h2 class="app_card_heading"></h2>
              <p></p>
              <a href="#" class="app_card_button"></a>
            </div>
          </div>
        </li>
        <li class="app_cards_item">
          <div class="app_card">
            <div class="app_card_image">
              <img src="//placehold.it/500x300&text=%20" />
            </div>

            <div class="app_card_content">
              <h2 class="app_card_heading"></h2>
              <p></p>
              <a href="#" class="app_card_button"></a>
            </div>
          </div>
        </li>
      </ul>
    </>
  );
}
