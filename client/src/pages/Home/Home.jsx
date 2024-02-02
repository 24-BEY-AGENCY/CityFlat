import React from "react";
import "./Home.css";
import Navbar from "../../components/navbar/Navbar";
import logo from "../../assets/homepage_mats/logo.png";
import name from "../../assets/homepage_mats/name.png";
import house from "../../assets/homepage_mats/Vector.png"
import RangeSlider from "../../components/rangeslider/RangeSlider";
import Cards from "../../components/cards/Cards";

export default function Home() {
  return (
    <>
      <div className="_home">
        <Navbar />
        <div className="wrapper">
          <div className="layer"></div>
          <div className="_home_content">
            <div className="_home_img">
              <img src={logo} />
              <img src={name} />
            </div>
            <div className="_home_text">
              <h1>Town lofts</h1>
              <span>
                am{" "}
                <svg
                  width="476"
                  height="46"
                  viewBox="0 0 476 46"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g clipPath="url(#clip0_20_12)">
                    <path
                      d="M16.283 46H0.337402V0H7.93872C9.08177 0 10.2248 0 11.425 0C12.6252 0 13.7683 0.109524 14.8542 0.164286C15.9401 0.219048 16.9117 0.328571 17.8261 0.438095C18.7406 0.547619 19.3693 0.657143 19.8836 0.821429C22.7413 1.5881 25.0274 2.95714 26.7991 4.92857C28.5709 6.79048 29.4282 9.14524 29.4282 11.9381C29.4282 13.6357 28.9709 15.2238 28.1136 16.6476C27.4278 18.0714 26.2276 19.4405 24.513 20.7C30.0568 23.219 32.8002 27.1619 32.8002 32.4738C32.8002 35.2119 32.1143 37.5667 30.7427 39.5381C29.1995 41.6738 27.4278 43.3167 25.3703 44.4667C23.1413 45.4524 20.0551 46 16.2259 46H16.283ZM13.8255 18.181C15.9973 18.181 17.7118 17.6881 18.9692 16.7024C19.998 15.7714 20.5123 14.5667 20.5123 13.0333C20.5123 11.5 19.998 10.35 18.9692 9.63809C17.8833 8.7619 16.3402 8.37857 14.2827 8.37857H9.48185V18.181H13.8255ZM14.0541 37.6214C17.8833 37.6214 20.4552 37.1833 21.884 36.3619C23.2557 35.3762 23.9415 34.0071 23.9415 32.3095C23.9415 30.3929 23.1985 28.8595 21.7125 27.6C20.0551 26.45 17.4832 25.9024 13.8826 25.9024H9.539V37.6214H14.1112H14.0541Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M59.3762 46C52.575 46 46.8598 43.7548 42.2875 39.2643C37.7153 34.6095 35.4292 29.2429 35.4292 23.1095C35.4292 18.7833 36.5151 14.8952 38.6298 11.4452C40.6873 7.94048 43.602 5.14762 47.317 3.06667C51.0319 0.985714 55.0326 0 59.3191 0C65.7202 0 71.264 2.24524 75.9505 6.73571C80.6942 11.3357 83.0374 16.7571 83.0374 23.1095C83.0374 29.4619 80.7513 35.0476 76.1791 39.4286C71.5497 43.8095 65.9488 46 59.3191 46H59.3762ZM59.3762 38.0595C61.4337 38.0595 63.2626 37.6762 65.0343 36.9643C66.8061 36.2524 68.3492 35.1571 69.8352 33.7333C72.8071 30.9405 74.2931 27.4357 74.2931 23.1095C74.2931 18.7833 72.8071 15.4429 69.8352 12.431C66.9775 9.58333 63.434 8.10476 59.1476 8.10476C54.8611 8.10476 51.2605 9.52857 48.5172 12.431C45.6595 15.169 44.2307 18.7286 44.2307 23.1095C44.2307 27.9833 46.0596 31.8714 49.7745 34.7738C52.575 36.9643 55.7756 38.0595 59.3762 38.0595Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M122.187 46H112.357L103.612 30.2833H98.2972V46H89.0956V0H106.699C110.985 0 114.643 1.42381 117.672 4.32619C120.701 7.22857 122.187 10.7333 122.187 14.8405V15.2786C122.187 21.5214 119.044 26.0667 112.814 29.0238L122.187 46ZM105.784 21.6857C107.613 21.6857 109.213 21.0286 110.528 19.7143C111.842 18.4548 112.528 16.8667 112.528 15.0048C112.528 13.1429 111.842 11.6643 110.528 10.4595C109.213 9.2 107.613 8.59762 105.784 8.59762H98.24V21.7405H105.784V21.6857Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M152.764 0H161.68V29.1881C161.68 31.5429 161.222 33.7333 160.308 35.7595C159.393 37.7857 158.136 39.5929 156.536 41.1262C154.936 42.6595 153.05 43.8643 150.935 44.7405C148.82 45.6167 146.534 46.0548 144.077 46.0548C141.619 46.0548 139.333 45.6167 137.218 44.7405C135.104 43.8643 133.218 42.6595 131.617 41.1262C130.017 39.5929 128.76 37.8405 127.845 35.7595C126.931 33.6786 126.474 31.5429 126.474 29.1881V0H135.389V29.3524C135.389 30.5024 135.618 31.5976 136.075 32.5833C136.532 33.569 137.161 34.4452 137.961 35.2119C138.761 35.9786 139.676 36.5262 140.705 36.9643C141.733 37.4024 142.876 37.6214 144.077 37.6214C145.277 37.6214 146.42 37.4024 147.449 36.9643C148.477 36.5262 149.392 35.9238 150.192 35.2119C150.992 34.5 151.621 33.569 152.078 32.5833C152.535 31.5976 152.764 30.5024 152.764 29.3524V0Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M180.769 46C174.368 46 169.452 42.8238 166.08 36.4167L173.567 32.1452C175.739 36.0881 178.254 38.0595 180.997 38.0595C182.426 38.0595 183.741 37.6762 184.827 36.8548C185.798 35.9786 186.313 35.0476 186.313 34.0071C186.313 32.9667 185.97 31.981 185.284 30.9405C184.827 30.4476 184.198 29.8452 183.341 29.0786C182.483 28.3119 181.455 27.4357 180.14 26.45C177.682 24.4786 175.682 22.781 174.082 21.3024C172.482 19.8238 171.339 18.5643 170.596 17.5238C169.052 15.3881 168.252 13.3071 168.252 11.2262C168.252 8.15952 169.452 5.53095 171.853 3.28571C174.368 1.09524 177.34 0 180.769 0C183.112 0 185.341 0.547619 187.341 1.64286C188.37 2.13571 189.456 2.84762 190.599 3.77857C191.742 4.70952 192.885 5.80476 194.142 7.17381L187.57 12.65C185.341 9.69286 183.112 8.21429 180.769 8.21429C179.454 8.21429 178.54 8.4881 178.025 9.03571C177.34 9.58333 176.939 10.2405 176.939 11.1167C176.939 11.7738 177.168 12.431 177.568 13.0881C177.968 13.5262 178.711 14.1833 179.797 15.1143C180.883 16.0452 182.255 17.1952 183.969 18.619C185.97 20.2071 187.513 21.5214 188.541 22.4524C189.227 23.0548 189.742 23.4929 190.085 23.7119C193.228 26.6143 194.771 29.9 194.771 33.6786C194.771 37.4571 193.514 40.3595 190.942 42.6595C188.37 44.9595 184.998 46.1095 180.769 46.1095V46Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M215.117 46C208.716 46 203.801 42.8238 200.429 36.4167L207.916 32.1452C210.088 36.0881 212.603 38.0595 215.346 38.0595C216.775 38.0595 218.089 37.6762 219.175 36.8548C220.147 35.9786 220.661 35.0476 220.661 34.0071C220.661 32.9667 220.318 31.981 219.632 30.9405C219.175 30.4476 218.547 29.8452 217.689 29.0786C216.832 28.3119 215.803 27.4357 214.489 26.45C212.031 24.4786 210.031 22.781 208.431 21.3024C206.83 19.8238 205.687 18.5643 204.944 17.5238C203.401 15.3881 202.601 13.3071 202.601 11.2262C202.601 8.15952 203.801 5.53095 206.202 3.28571C208.716 1.09524 211.688 0 215.117 0C217.461 0 219.69 0.547619 221.69 1.64286C222.719 2.13571 223.805 2.84762 224.948 3.77857C226.091 4.70952 227.234 5.80476 228.491 7.17381L221.919 12.65C219.69 9.69286 217.461 8.21429 215.117 8.21429C213.803 8.21429 212.888 8.4881 212.374 9.03571C211.688 9.58333 211.288 10.2405 211.288 11.1167C211.288 11.7738 211.517 12.431 211.917 13.0881C212.317 13.5262 213.06 14.1833 214.146 15.1143C215.232 16.0452 216.603 17.1952 218.318 18.619C220.318 20.2071 221.861 21.5214 222.89 22.4524C223.576 23.0548 224.09 23.4929 224.433 23.7119C227.577 26.6143 229.12 29.9 229.12 33.6786C229.12 37.4571 227.862 40.3595 225.291 42.6595C222.719 44.9595 219.347 46.1095 215.117 46.1095V46Z"
                      fill="#F7D86A"
                    />
                    <path d="M234.835 0H243.751V46H234.835V0Z" fill="#F7D86A" />
                    <path
                      d="M277.928 0L278.157 0.657143L273.47 12.2667L266.955 28.0929H279.929L276.842 20.5905L281.529 8.98095L296.503 46H286.844L283.301 36.581H263.64L259.639 46H250.266L268.784 0H277.986H277.928Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M331.252 46H322.05V0H339.653C343.94 0 347.54 1.42381 350.627 4.32619C353.713 7.22857 355.256 10.7333 355.256 14.7857V15.3881C355.256 19.4405 353.713 22.9452 350.627 25.8476C347.54 28.6952 343.94 30.1738 339.653 30.1738H331.252V46ZM338.739 21.5762C340.682 21.5762 342.225 20.9738 343.483 19.769C344.74 18.5643 345.369 17.031 345.369 15.2238C345.369 13.4167 344.74 11.8286 343.483 10.5143C342.225 9.25476 340.625 8.59762 338.739 8.59762H331.252V21.631H338.739V21.5762Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M378.689 0L378.917 0.657143L374.231 12.2667L367.715 28.0929H380.689L377.603 20.5905L382.289 8.98095L397.263 46H387.604L384.061 36.581H364.4L360.4 46H351.027L369.544 0H378.746H378.689Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M435.842 46H426.011L417.267 30.2833H411.952V46H402.75V0H420.353C424.64 0 428.297 1.42381 431.326 4.32619C434.356 7.22857 435.842 10.7333 435.842 14.8405V15.2786C435.842 21.5214 432.698 26.0667 426.468 29.0238L435.842 46ZM419.439 21.6857C421.268 21.6857 422.868 21.0286 424.182 19.7143C425.497 18.4548 426.183 16.8667 426.183 15.0048C426.183 13.1429 425.497 11.6643 424.182 10.4595C422.868 9.2 421.268 8.59762 419.439 8.59762H411.894V21.7405H419.439V21.6857Z"
                      fill="#F7D86A"
                    />
                    <path
                      d="M474.991 0L458.474 23.1095L474.991 46H464.075L449.329 25.4643V46H440.185V0H449.329V20.5905L464.075 0H474.991Z"
                      fill="#F7D86A"
                    />
                  </g>
                  <defs>
                    <clipPath id="clip0_20_12">
                      <rect width="476" height="46" fill="white" />
                    </clipPath>
                  </defs>
                </svg>
              </span>
            </div>
            <div className="_price_wrapper">
              <div className="price">
                <div className="price_range">
                  <span>Price Range</span>
                  <RangeSlider
                    min={0}
                    max={1000}
                    onChange={({ min, max }) =>
                      console.log(`min = ${min}, max = ${max}`)
                    }
                  />
                </div>
                <div className="_counter">
                  <span>Rooms</span>
                  <div className="_counter_btns">
                    <button>+</button>
                    <span>0</span>
                    <button>-</button>
                  </div>
                </div>
                <div className="_filter">
                  <svg
                    width="39"
                    height="39"
                    viewBox="0 0 39 39"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      fillRule="evenodd"
                      clipRule="evenodd"
                      d="M16.4863 28.0312C16.9684 26.8402 18.1361 26 19.5 26C20.8639 26 22.0316 26.8402 22.5137 28.0312H34.125C34.7981 28.0312 35.3438 28.5769 35.3438 29.25C35.3438 29.9231 34.7981 30.4688 34.125 30.4688H22.5137C22.0316 31.6598 20.8639 32.5 19.5 32.5C18.1361 32.5 16.9684 31.6598 16.4863 30.4688H4.875C4.20193 30.4688 3.65625 29.9231 3.65625 29.25C3.65625 28.5769 4.20193 28.0312 4.875 28.0312H16.4863ZM35.3438 19.5C35.3438 20.1731 34.7981 20.7188 34.125 20.7188H17.875C17.2019 20.7188 16.6562 20.1731 16.6562 19.5C16.6562 18.8269 17.2019 18.2812 17.875 18.2812H34.125C34.7981 18.2812 35.3438 18.8269 35.3438 19.5ZM11.375 22.75C10.0111 22.75 8.84341 21.9099 8.36127 20.7188H4.875C4.20193 20.7188 3.65625 20.1731 3.65625 19.5C3.65625 18.8269 4.20193 18.2812 4.875 18.2812H8.36127C8.84341 17.0901 10.0111 16.25 11.375 16.25C13.17 16.25 14.625 17.705 14.625 19.5C14.625 21.295 13.17 22.75 11.375 22.75ZM19.5 10.9688C20.1731 10.9688 20.7188 10.4231 20.7188 9.75C20.7188 9.07693 20.1731 8.53125 19.5 8.53125H6.5C5.82693 8.53125 5.28125 9.07693 5.28125 9.75C5.28125 10.4231 5.82693 10.9688 6.5 10.9688H19.5ZM35.3438 9.75C35.3438 10.4231 34.7981 10.9688 34.125 10.9688H29.0138C28.5316 12.1599 27.3639 13 26 13C24.2051 13 22.75 11.545 22.75 9.75C22.75 7.95502 24.2051 6.5 26 6.5C27.3639 6.5 28.5316 7.34012 29.0138 8.53125H34.125C34.7981 8.53125 35.3438 9.07693 35.3438 9.75Z"
                      fill="white"
                      fillOpacity="0.73"
                    />
                  </svg>
                  <span>FILTER</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="_cards_container">
          <div className="cards_layer"></div>
          <Cards />
          <Cards />
          <Cards />
          <Cards />
          <Cards />
          <Cards />
        </div>
        <section className="_search_container">
          <div className="img_ctr">
            <div className="_floating_img">
              <p>test</p>
              <p>test</p>
            </div>
          </div>
          <div className="search_content">
            <div className="_content">
              <div className="search_title">
                <h1>
                  Just Click, <span>Big Move</span> !
                </h1>
              </div>
              <div className="search_description">
                <p>
                  Lorem ipsum dolor sit amet consectetur, adipisicing elit.
                  Quibusdam quod, aliquid repudiandae vero cumque eligendi modi
                  iusto ut delectus distinctio reiciendis autem quia, accusamus,
                  minus aspernatur rerum sunt a maxime.
                </p>
              </div>
              <div className="search_boxes">
                <div className="_box">
                    <img src={house} />
                  <p>Searching For House</p>
                </div>
                <div className="_box">
                    <img src={house} />
                  <p>Searching For House</p>
                </div>
                <div className="_box">
                    <img src={house} />
                  <p>Searching For House</p>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section className="_testimonial_container"></section>
      </div>
    </>
  );
}
