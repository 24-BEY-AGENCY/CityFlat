import React, { useState, useEffect } from "react";
import "./Dashboard.css";
import logo from "../../assets/homepage_mats/logo_h.png";
import DashContent from "./DashComponents/DashContent/DashContent";
import BookingsContent from "./DashComponents/BookingsContent/BookingsContent";
import AppartementsContent from "./DashComponents/AppartementsContent/AppartementsContent";

function Dashboard() {
  const [isNavClosed, setIsNavClosed] = useState(window.innerWidth <= 991);
  const [activeIndex, setActiveIndex] = useState(0);

  const handleClick = (index) => {
    setActiveIndex(index);
  };

  const handleMenuButtonClick = () => {
    setIsNavClosed(!isNavClosed);
  };

  const handlePageContentClick = () => {
    if (window.innerWidth <= 991) {
      setIsNavClosed(true);
    }
  };

  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth > 991) {
        setIsNavClosed(false);
      }
    };

    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return (
    <div className={`_dash_container ${isNavClosed ? "nav-closed" : ""}`}>
      <div className="header">
        <div className="header-logo">
          <img src={logo} alt="City Flat" />
        </div>
        <div className="header-search">
          <button className="button-menu" onClick={handleMenuButtonClick}>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 385 385">
              <path d="M12 120.3h361a12 12 0 000-24H12a12 12 0 000 24zM373 180.5H12a12 12 0 000 24h361a12 12 0 000-24zM373 264.7H132.2a12 12 0 000 24H373a12 12 0 000-24z" />
            </svg>
          </button>
          <div className="dash_nav_icons d-flex gap-3">
            <svg
              width="70"
              height="49"
              viewBox="0 0 106 49"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <g filter="url(#filter0_i_0_1)">
                <rect
                  width="106"
                  height="49"
                  rx="24.5"
                  fill="#1B1D23"
                  fill-opacity="0.09"
                />
              </g>
              <rect
                x="0.25"
                y="0.25"
                width="105.5"
                height="48.5"
                rx="24.25"
                stroke="#0DB254"
                stroke-opacity="0.72"
                stroke-width="0.5"
              />
              <g clip-path="url(#clip0_0_1)">
                <path
                  d="M24.5153 17.6094L17.2653 24.8594C17.0954 25.0293 17 25.2598 17 25.5001C17 25.7404 17.0954 25.9709 17.2653 26.1408L24.5153 33.3908C24.5989 33.4774 24.6989 33.5464 24.8095 33.5939C24.9201 33.6414 25.039 33.6664 25.1593 33.6674C25.2796 33.6685 25.399 33.6456 25.5104 33.6C25.6217 33.5544 25.7229 33.4871 25.808 33.402C25.8931 33.317 25.9604 33.2158 26.006 33.1044C26.0515 32.993 26.0745 32.8737 26.0734 32.7534C26.0724 32.633 26.0474 32.5141 25.9999 32.4035C25.9524 32.293 25.8833 32.193 25.7968 32.1094L20.0937 26.4063L45.0936 26.4063C45.3339 26.4063 45.5644 26.3109 45.7344 26.1409C45.9043 25.971 45.9998 25.7404 45.9998 25.5001C45.9998 25.2597 45.9043 25.0292 45.7344 24.8593C45.5644 24.6893 45.3339 24.5938 45.0936 24.5938L20.0937 24.5938L25.7968 18.8908C25.9619 18.7199 26.0532 18.491 26.0511 18.2534C26.0491 18.0157 25.9538 17.7884 25.7857 17.6204C25.6177 17.4524 25.3904 17.3571 25.1528 17.355C24.9152 17.353 24.6863 17.4443 24.5153 17.6094Z"
                  fill="white"
                />
              </g>
              <path
                d="M76.1554 30.7488V37H70.8446V30.7488C70.8446 30.0383 71.1243 29.3569 71.6223 28.8545C72.1203 28.352 72.7957 28.0698 73.5 28.0698C74.2043 28.0698 74.8797 28.352 75.3777 28.8545C75.8757 29.3569 76.1554 30.0383 76.1554 30.7488ZM84.6085 19.2914L73.9868 12.1472C73.8423 12.0512 73.673 12 73.5 12C73.327 12 73.1577 12.0512 73.0132 12.1472L62.3915 19.2914C62.2345 19.3978 62.1154 19.5521 62.0517 19.7318C61.988 19.9114 61.983 20.1069 62.0375 20.2896C62.0919 20.4724 62.2029 20.6327 62.3542 20.7471C62.5055 20.8616 62.6892 20.9241 62.8783 20.9256H63.7634V34.3209C63.7634 35.0315 64.0432 35.7129 64.5412 36.2153C65.0392 36.7177 65.7146 37 66.4189 37H69.0743V30.7488C69.0743 29.5646 69.5406 28.4289 70.3706 27.5915C71.2005 26.7542 72.3262 26.2837 73.5 26.2837C74.6738 26.2837 75.7995 26.7542 76.6294 27.5915C77.4594 28.4289 77.9257 29.5646 77.9257 30.7488V37H80.5811C81.2854 37 81.9608 36.7177 82.4588 36.2153C82.9568 35.7129 83.2366 35.0315 83.2366 34.3209V20.9256H84.1217C84.3108 20.9241 84.4945 20.8616 84.6458 20.7471C84.7971 20.6327 84.9081 20.4724 84.9625 20.2896C85.017 20.1069 85.012 19.9114 84.9483 19.7318C84.8846 19.5521 84.7655 19.3978 84.6085 19.2914Z"
                fill="url(#paint0_linear_0_1)"
              />
              <defs>
                <filter
                  id="filter0_i_0_1"
                  x="-5"
                  y="-3"
                  width="111"
                  height="52"
                  filterUnits="userSpaceOnUse"
                  color-interpolation-filters="sRGB"
                >
                  <feFlood flood-opacity="0" result="BackgroundImageFix" />
                  <feBlend
                    mode="normal"
                    in="SourceGraphic"
                    in2="BackgroundImageFix"
                    result="shape"
                  />
                  <feColorMatrix
                    in="SourceAlpha"
                    type="matrix"
                    values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    result="hardAlpha"
                  />
                  <feOffset dx="-5" dy="-3" />
                  <feGaussianBlur stdDeviation="4.7" />
                  <feComposite
                    in2="hardAlpha"
                    operator="arithmetic"
                    k2="-1"
                    k3="1"
                  />
                  <feColorMatrix
                    type="matrix"
                    values="0 0 0 0 0.14915 0 0 0 0 0.159363 0 0 0 0 0.19 0 0 0 1 0"
                  />
                  <feBlend
                    mode="normal"
                    in2="shape"
                    result="effect1_innerShadow_0_1"
                  />
                </filter>
                <linearGradient
                  id="paint0_linear_0_1"
                  x1="80.7339"
                  y1="31.5122"
                  x2="65.5535"
                  y2="17.6589"
                  gradientUnits="userSpaceOnUse"
                >
                  <stop stop-color="#07D25F" />
                  <stop offset="1" stop-color="#028139" />
                </linearGradient>
                <clipPath id="clip0_0_1">
                  <rect
                    width="29"
                    height="29"
                    fill="white"
                    transform="translate(17 40) rotate(-90)"
                  />
                </clipPath>
              </defs>
            </svg>
            <svg
              width="35"
              height="49"
              viewBox="0 0 49 49"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <g filter="url(#filter0_i_0_1)">
                <rect
                  width="49"
                  height="49"
                  rx="24.5"
                  fill="#1B1D23"
                  fill-opacity="0.09"
                />
              </g>
              <rect
                x="0.25"
                y="0.25"
                width="48.5"
                height="48.5"
                rx="24.25"
                stroke="#0DB254"
                stroke-opacity="0.72"
                stroke-width="0.5"
              />
              <path
                d="M24.3333 25.3254C28.3834 25.3254 31.6667 22.0421 31.6667 17.992C31.6667 13.9419 28.3834 10.6587 24.3333 10.6587C20.2832 10.6587 17 13.9419 17 17.992C17 22.0421 20.2832 25.3254 24.3333 25.3254Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M32.3333 27.584C29.712 27.584 27.584 29.712 27.584 32.3333C27.584 34.9547 29.712 37.084 32.3333 37.084C34.9547 37.084 37.084 34.9547 37.084 32.3333C37.084 29.712 34.9547 27.584 32.3333 27.584ZM32.3333 29.584C33.8507 29.584 35.084 30.816 35.084 32.3333C35.084 33.8507 33.8507 35.084 32.3333 35.084C30.816 35.084 29.5827 33.8507 29.5827 32.3333C29.5827 30.816 30.816 29.584 32.3333 29.584Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M33.333 28.5826V26.3333C33.333 25.7813 32.885 25.3333 32.333 25.3333C31.781 25.3333 31.333 25.7813 31.333 26.3333V28.5839C31.333 29.1346 31.781 29.5839 32.333 29.5839C32.885 29.5826 33.333 29.1346 33.333 28.5826Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M35.692 30.3894L37.2827 28.7974C37.6734 28.4081 37.6734 27.7734 37.2827 27.3841C36.8934 26.9934 36.2587 26.9934 35.8694 27.3841L34.2774 28.9747C33.888 29.3654 33.888 29.9987 34.2774 30.3894C34.668 30.7787 35.3014 30.7787 35.692 30.3894Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M36.0827 33.3333H38.3333C38.8853 33.3333 39.3333 32.8853 39.3333 32.3333C39.3333 31.7813 38.8853 31.3333 38.3333 31.3333H36.0827C35.532 31.3333 35.084 31.7813 35.084 32.3333C35.0827 32.8853 35.532 33.3333 36.0827 33.3333Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M34.2774 35.692L35.8694 37.2827C36.2587 37.6734 36.8934 37.6734 37.2827 37.2827C37.6734 36.8934 37.6734 36.2587 37.2827 35.8694L35.692 34.2774C35.3014 33.888 34.668 33.888 34.2774 34.2774C33.888 34.668 33.888 35.3014 34.2774 35.692Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M31.333 36.0828V38.3334C31.333 38.8854 31.781 39.3334 32.333 39.3334C32.885 39.3334 33.333 38.8854 33.333 38.3334V36.0828C33.333 35.5321 32.885 35.0841 32.333 35.0828C31.781 35.0828 31.333 35.5321 31.333 36.0828Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M28.9745 34.2774L27.3838 35.8694C26.9932 36.2587 26.9932 36.8934 27.3838 37.2827C27.7732 37.6734 28.4078 37.6734 28.7972 37.2827L30.3892 35.692C30.7785 35.3014 30.7785 34.668 30.3892 34.2774C29.9985 33.888 29.3652 33.888 28.9745 34.2774Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M28.5823 31.3333H26.333C25.781 31.3333 25.333 31.7813 25.333 32.3333C25.333 32.8853 25.781 33.3333 26.333 33.3333H28.5823C29.1343 33.3333 29.5837 32.8853 29.5823 32.3333C29.5823 31.7813 29.1343 31.3333 28.5823 31.3333Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M30.3892 28.9747L28.7972 27.3841C28.4078 26.9934 27.7732 26.9934 27.3838 27.3841C26.9932 27.7734 26.9932 28.4081 27.3838 28.7974L28.9745 30.3894C29.3652 30.7787 29.9985 30.7787 30.3892 30.3894C30.7785 29.9987 30.7785 29.3654 30.3892 28.9747Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M26.2478 38.0079C25.5358 37.0933 25.5998 35.7666 26.4412 34.9266L26.6998 34.6666H26.3332C25.0452 34.6666 23.9998 33.6213 23.9998 32.3333C23.9998 31.0453 25.0452 29.9999 26.3332 29.9999H26.6998L26.4412 29.7399C25.5665 28.8666 25.5318 27.4679 26.3372 26.5519C25.6838 26.5013 25.0145 26.4746 24.3332 26.4746C19.9038 26.4746 15.9825 27.5826 13.5478 29.2426C11.6905 30.5093 10.6665 32.1186 10.6665 33.8079V35.7413C10.6665 36.3426 10.9052 36.9199 11.3305 37.3439C11.7558 37.7693 12.3318 38.0079 12.9332 38.0079H26.2478Z"
                fill="white"
              />
              <defs>
                <filter
                  id="filter0_i_0_1"
                  x="-5"
                  y="-3"
                  width="54"
                  height="52"
                  filterUnits="userSpaceOnUse"
                  color-interpolation-filters="sRGB"
                >
                  <feFlood flood-opacity="0" result="BackgroundImageFix" />
                  <feBlend
                    mode="normal"
                    in="SourceGraphic"
                    in2="BackgroundImageFix"
                    result="shape"
                  />
                  <feColorMatrix
                    in="SourceAlpha"
                    type="matrix"
                    values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    result="hardAlpha"
                  />
                  <feOffset dx="-5" dy="-3" />
                  <feGaussianBlur stdDeviation="4.7" />
                  <feComposite
                    in2="hardAlpha"
                    operator="arithmetic"
                    k2="-1"
                    k3="1"
                  />
                  <feColorMatrix
                    type="matrix"
                    values="0 0 0 0 0.14915 0 0 0 0 0.159363 0 0 0 0 0.19 0 0 0 1 0"
                  />
                  <feBlend
                    mode="normal"
                    in2="shape"
                    result="effect1_innerShadow_0_1"
                  />
                </filter>
              </defs>
            </svg>
          </div>
        </div>
      </div>
      <div className="main">
        <div className="sidebar">
          <ul>
            <li onClick={() => handleClick(0)}>
              <a href="#" className={activeIndex === 0 ? "active" : ""}>
                <svg
                  width="19"
                  height="19"
                  viewBox="0 0 19 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g clip-path="url(#clip0_161_2419)">
                    <path
                      d="M17.676 0.403076H1.32445C0.748692 0.403076 0.288086 0.863682 0.288086 1.41065V14.6531C0.288086 15.2288 0.748692 15.6894 1.32445 15.6894H17.7048C18.2805 15.6894 18.7411 15.2288 18.7411 14.6531V1.41065C18.7123 0.863682 18.2517 0.403076 17.676 0.403076ZM10.3063 14.5955H8.43505C8.29112 14.5955 8.14718 14.4516 8.14718 14.3076C8.14718 14.1637 8.29112 14.0197 8.43505 14.0197H10.3063C10.479 14.0197 10.5941 14.1637 10.5941 14.3076C10.5941 14.4516 10.4502 14.5955 10.3063 14.5955ZM18.1366 12.9258H0.863844V1.41065C0.863844 1.15156 1.06536 0.950046 1.32445 0.950046H17.7048C17.9638 0.950046 18.1654 1.15156 18.1654 1.41065V12.9258H18.1366Z"
                      fill="white"
                    />
                    <path
                      d="M12.7532 18.0789L12.4365 17.8486C11.8895 17.4456 11.5153 16.8986 11.3138 16.2653H7.68649C7.48497 16.8986 7.11073 17.4456 6.56376 17.8486L6.21831 18.0789C6.10316 18.1653 6.07437 18.2804 6.10316 18.3956C6.13194 18.5107 6.2471 18.5971 6.39104 18.5971H12.5804C12.6956 18.5971 12.8107 18.5107 12.8683 18.3956C12.8971 18.2804 12.8683 18.1653 12.7532 18.0789Z"
                      fill="white"
                    />
                    <path
                      d="M13.5883 5.35454V2.3606C12.005 2.50454 10.7671 3.82878 10.7671 5.46969C10.7671 6.21817 11.0262 6.90908 11.4868 7.45605L13.5883 5.35454Z"
                      fill="white"
                    />
                    <path
                      d="M14.1641 2.3606V5.29696L16.6686 6.82272C16.8701 6.41969 16.9853 5.95908 16.9853 5.46969C16.9853 3.85757 15.7474 2.50454 14.1641 2.3606Z"
                      fill="white"
                    />
                    <path
                      d="M11.8896 7.85912C12.4366 8.31973 13.1275 8.57882 13.876 8.57882C14.9124 8.57882 15.8048 8.08943 16.3806 7.31216L13.9336 5.81519L11.8896 7.85912Z"
                      fill="white"
                    />
                    <path
                      d="M11.2848 10.9682H10.7379V8.23335C10.7379 8.08941 10.6227 7.94547 10.45 7.94547H9.09695C8.92423 7.94547 8.80908 8.08941 8.80908 8.23335V10.9682H7.77271V8.08941C7.77271 7.94547 7.65756 7.80153 7.48483 7.80153H6.1318C5.95908 7.80153 5.84392 7.94547 5.84392 8.08941V10.9682H4.80756V4.37577C4.80756 4.23183 4.69241 4.08789 4.51968 4.08789H3.16665C2.99392 4.08789 2.87877 4.23183 2.87877 4.37577V10.9682H2.30302C2.15908 10.9682 2.01514 11.1121 2.01514 11.2561C2.01514 11.4 2.15908 11.544 2.30302 11.544H11.2848C11.4288 11.544 11.5727 11.4 11.5727 11.2561C11.5727 11.1121 11.4576 10.9682 11.2848 10.9682Z"
                      fill="white"
                    />
                  </g>
                  <defs>
                    <clipPath id="clip0_161_2419">
                      <rect width="19" height="19" fill="white" />
                    </clipPath>
                  </defs>
                </svg>
                <span>Dashboard</span>
              </a>
            </li>
            <li onClick={() => handleClick(1)}>
              <a href="#" className={activeIndex === 1 ? "active" : ""}>
                <svg
                  width="19"
                  height="19"
                  viewBox="0 0 19 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g clip-path="url(#clip0_157_2055)">
                    <path
                      d="M15.0929 0.575195H3.90717C1.75275 0.575195 0 2.32795 0 4.48237C0 6.64722 1.77097 8.38954 3.88387 8.38954H5.63877V5.32824C5.63877 3.95727 6.75409 2.84191 8.12502 2.84191H8.13044C9.49848 2.84484 10.6114 3.9602 10.6114 5.32824V8.38954H15.0929C17.2473 8.38954 19 6.63679 19 4.48237C19 2.32795 17.2473 0.575195 15.0929 0.575195ZM16.1985 3.93753L13.9719 6.16409C13.7546 6.38148 13.4021 6.38151 13.1847 6.16409L12.0715 5.05081C11.8541 4.83342 11.8541 4.48099 12.0715 4.26361C12.2888 4.04622 12.6413 4.04622 12.8587 4.26361L13.5784 4.98327L15.4113 3.15033C15.6287 2.93294 15.9812 2.93294 16.1985 3.15033C16.4159 3.36771 16.4159 3.72018 16.1985 3.93753Z"
                      fill="white"
                    />
                    <path
                      d="M13.0817 9.956L9.49833 9.58353V5.32813C9.49833 4.57095 8.88539 3.95671 8.12821 3.95508C7.36877 3.95345 6.75223 4.56865 6.75223 5.32813V12.4501H6.73976L5.38442 11.3183C4.81275 10.8409 3.95968 10.9304 3.49952 11.516C3.05825 12.0777 3.14346 12.8883 3.69182 13.3459L6.44285 15.6415H14.5452V11.6131C14.5452 10.7706 13.9177 10.0601 13.0817 9.956Z"
                      fill="white"
                    />
                    <path
                      d="M6.75195 17.8682C6.75195 18.1756 7.00118 18.4248 7.30859 18.4248H13.9883C14.2957 18.4248 14.5449 18.1756 14.5449 17.8682V16.7549H6.75195V17.8682Z"
                      fill="white"
                    />
                  </g>
                  <defs>
                    <clipPath id="clip0_157_2055">
                      <rect width="19" height="19" fill="white" />
                    </clipPath>
                  </defs>
                </svg>

                <span>Bookings</span>
              </a>
            </li>
            <li onClick={() => handleClick(2)}>
              <a href="#" className={activeIndex === 2 ? "active" : ""}>
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 15 15"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g clip-path="url(#clip0_157_2061)">
                    <path
                      d="M0 0V1.50001H0.749988V15H5.99997V12H8.99999V15H14.25V1.50001H15V0H0ZM4.5 10.5H2.99999V8.99999H4.5V10.5ZM4.5 7.49998H2.99999V5.99997H4.5V7.49998ZM4.5 4.5H2.99999V2.99999H4.5V4.5ZM8.25001 10.5H6.75V8.99999H8.25001V10.5ZM8.25001 7.49998H6.75V5.99997H8.25001V7.49998ZM8.25001 4.5H6.75V2.99999H8.25001V4.5ZM12 10.5H10.5V8.99999H12V10.5ZM12 7.49998H10.5V5.99997H12V7.49998ZM12 4.5H10.5V2.99999H12V4.5Z"
                      fill="white"
                    />
                  </g>
                  <defs>
                    <clipPath id="clip0_157_2061">
                      <rect width="15" height="15" fill="white" />
                    </clipPath>
                  </defs>
                </svg>

                <span>Appartements</span>
              </a>
            </li>
            <li onClick={() => handleClick(3)}>
              <a href="#" className={activeIndex === 3 ? "active" : ""}>
                <svg
                  width="18"
                  height="18"
                  viewBox="0 0 18 18"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M7.03182 2.59485C5.50407 2.59485 4.25419 3.84529 4.25419 5.37247C4.25419 6.89966 5.50463 8.1501 7.03182 8.1501C8.559 8.1501 9.80944 6.8991 9.80944 5.37247C9.81 3.84529 8.559 2.59485 7.03182 2.59485ZM0.562504 14.8405C0.561379 15.1532 0.814504 15.4063 1.12725 15.4052H12.9364C13.2491 15.4063 13.5023 15.1527 13.5011 14.8405C13.5011 11.7608 11.3434 9.1761 8.45157 8.52866C8.2395 8.47916 8.01788 8.55679 7.88232 8.72779L7.08919 9.74085L6.30057 8.71091C6.19763 8.57366 6.03675 8.49154 5.805 8.49322C2.78832 9.09791 0.562504 11.7147 0.562504 14.8405ZM12.7125 2.94697C11.5459 2.94697 10.5868 3.90266 10.5868 5.06872C10.5868 6.23422 11.5459 7.19441 12.7125 7.19441C13.8786 7.19441 14.8337 6.23422 14.8337 5.06872C14.8337 3.90266 13.8786 2.94697 12.7125 2.94697ZM10.2769 7.98191C12.1815 8.88472 13.6457 10.5565 14.2791 12.5893H16.8773C17.1866 12.5877 17.4364 12.3385 17.4375 12.0291C17.4375 9.78079 15.8631 7.8891 13.7503 7.41604C13.5371 7.36766 13.3155 7.44697 13.1811 7.61854L12.7536 8.16304L12.3294 7.60616C12.2254 7.46779 12.0628 7.38454 11.8294 7.38847C11.232 7.50435 10.7297 7.70685 10.2769 7.98191Z"
                    fill="white"
                  />
                </svg>

                <span>Customers</span>
              </a>
            </li>
            <li onClick={() => handleClick(4)}>
              <a href="#" className={activeIndex === 4 ? "active" : ""}>
                <svg
                  width="19"
                  height="19"
                  viewBox="0 0 19 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g clip-path="url(#clip0_160_2106)">
                    <path
                      d="M2.81713 6.0206C2.96728 5.72599 3.1379 5.44227 3.32775 5.17153C3.75039 4.5705 4.2596 4.03528 4.83885 3.58325C4.94869 3.49716 5.05557 3.4081 5.17135 3.32497C5.44175 3.13621 5.72441 2.96562 6.01744 2.81435C6.2876 1.59419 7.74525 0.688721 9.49979 0.688721C11.2543 0.688721 12.712 1.57935 12.9792 2.81435C13.2728 2.96627 13.5564 3.13683 13.8282 3.32497C14.0836 3.50891 14.3285 3.70714 14.5615 3.91872C14.9767 4.29295 15.3491 4.71213 15.6718 5.16856C15.8617 5.4393 16.0323 5.72302 16.1824 6.01763C17.4085 6.28481 18.311 7.74247 18.311 9.497C18.311 11.2515 17.4056 12.7122 16.1824 12.9823C16.0305 13.274 15.8599 13.5556 15.6718 13.8254C15.5471 14.0065 15.4135 14.1787 15.271 14.3479C14.8496 14.85 14.3646 15.2951 13.8282 15.672C13.5564 15.8601 13.2728 16.0307 12.9792 16.1826C12.712 17.4058 11.2543 18.3112 9.49979 18.3112C7.74525 18.3112 6.2876 17.4206 6.02041 16.1826C5.72679 16.0307 5.44319 15.8601 5.17135 15.672C4.99322 15.5443 4.81807 15.4108 4.65182 15.2712C4.14891 14.8495 3.70372 14.3634 3.32775 13.8254C3.13965 13.5556 2.96909 13.274 2.81713 12.9823C1.594 12.7122 0.688536 11.2545 0.688536 9.49997C0.688536 7.74544 1.59104 6.28778 2.81713 6.0206ZM5.12682 4.10872L4.99619 4.2156C4.71585 4.4529 4.45568 4.71307 4.21838 4.99341L4.1115 5.12403C4.06103 5.18638 4.01353 5.25169 3.96307 5.317L5.82447 7.17544L5.86307 7.12497C5.92838 7.027 5.99369 6.93497 6.06494 6.84294C6.09166 6.81028 6.11541 6.77763 6.14213 6.74794C6.23119 6.6381 6.32322 6.53419 6.42119 6.43325C6.51916 6.33528 6.62604 6.24028 6.71807 6.15122L6.82791 6.06216C6.91697 5.99388 7.009 5.92856 7.104 5.86325L7.16338 5.82466L5.30197 3.96325L5.12682 4.10872ZM7.79869 12.8458C8.32808 13.1093 8.91139 13.2465 9.50275 13.2465C10.0941 13.2465 10.6774 13.1093 11.2068 12.8458C11.9123 12.4822 12.4863 11.9072 12.8485 11.2011C13.1103 10.6856 13.2494 10.1166 13.2553 9.53856V9.45841C13.2494 8.88032 13.1103 8.31138 12.8485 7.79591C12.4855 7.09115 11.9116 6.51724 11.2068 6.15419C10.6783 5.88772 10.0946 5.74891 9.50275 5.74891C8.91086 5.74891 8.32721 5.88772 7.79869 6.15419C7.53708 6.29133 7.2912 6.45657 7.06541 6.647C6.68999 6.96767 6.38132 7.35906 6.15697 7.79888C5.89525 8.31435 5.75606 8.88329 5.75025 9.46138V9.54153C5.75606 10.1196 5.89525 10.6886 6.15697 11.204C6.29055 11.4677 6.45606 11.714 6.64979 11.9373C6.97038 12.3104 7.35934 12.6187 7.79572 12.8458H7.79869ZM9.49979 1.28247C8.31229 1.28247 7.26135 1.76638 6.80713 2.46997C8.54063 1.80487 10.4589 1.80487 12.1924 2.46997C11.7382 1.78122 10.6873 1.28247 9.49979 1.28247ZM14.8881 5.12403L14.7812 4.99341C14.5439 4.71307 14.2837 4.4529 14.0034 4.2156L13.8728 4.10872L13.6828 3.96325L11.8213 5.82466L11.8778 5.86325C11.9728 5.9256 12.0678 5.99388 12.1568 6.06513L12.2548 6.13935C12.3617 6.22841 12.4685 6.32341 12.5695 6.42138C12.6689 6.52127 12.7631 6.62631 12.8515 6.73606L12.9287 6.83106C12.9999 6.9231 13.0653 7.01513 13.1276 7.11013L13.1692 7.16653L15.0306 5.3081C14.986 5.25169 14.9385 5.18638 14.8881 5.12403ZM17.7173 9.49997C17.7173 8.31247 17.2334 7.26153 16.5298 6.80731C17.1948 8.54185 17.1948 10.4611 16.5298 12.1956C17.2185 11.7414 17.7173 10.6875 17.7173 9.49997ZM13.8579 14.8912L13.9945 14.7814C14.2732 14.5433 14.5323 14.2832 14.7693 14.0036C14.8079 13.962 14.8406 13.9145 14.8762 13.8729L15.0246 13.6829L13.1632 11.8215C13.1632 11.8393 13.1365 11.8572 13.1246 11.8779C13.0593 11.9729 12.994 12.0679 12.9228 12.157L12.8485 12.252C12.7565 12.3618 12.6645 12.4687 12.5517 12.5697C12.4507 12.6676 12.3438 12.7626 12.237 12.8665L12.142 12.9408C12.049 13.012 11.95 13.0803 11.8451 13.1456L11.7917 13.1842L13.6531 15.0426C13.7451 14.9862 13.8074 14.9417 13.8698 14.8912H13.8579ZM9.49979 17.7175C10.6873 17.7175 11.7382 17.2306 12.1924 16.53C10.4589 17.1951 8.54063 17.1951 6.80713 16.53C7.26135 17.2187 8.31229 17.7175 9.49979 17.7175ZM4.1115 13.8581C4.14713 13.8997 4.17978 13.9472 4.21838 13.9887C4.45568 14.2691 4.71585 14.5292 4.99619 14.7665L5.12682 14.8734L5.31682 15.0189L7.17822 13.1604L7.12479 13.1218C7.02781 13.0565 6.92885 12.9883 6.82791 12.917L6.73291 12.8428C6.62603 12.7537 6.51916 12.6587 6.41822 12.5459C6.31728 12.445 6.22525 12.3381 6.12135 12.2283L6.04713 12.1333C5.97588 12.0442 5.91057 11.9492 5.84525 11.8542C5.84525 11.8334 5.81854 11.8156 5.80666 11.7978L3.94525 13.6592L4.1115 13.8581ZM2.46088 12.1808C1.79586 10.4462 1.79586 8.52701 2.46088 6.79247C1.76619 7.24669 1.27338 8.29466 1.27338 9.48513C1.27338 10.6756 1.76619 11.7414 2.46088 12.1956V12.1808Z"
                      fill="white"
                    />
                  </g>
                  <defs>
                    <clipPath id="clip0_160_2106">
                      <rect
                        width="19"
                        height="19"
                        fill="white"
                        transform="matrix(-1 0 0 1 19 0)"
                      />
                    </clipPath>
                  </defs>
                </svg>
                <span>help</span>
              </a>
            </li>
            <li onClick={() => handleClick(5)}>
              <a href="#" className={activeIndex === 5 ? "active" : ""}>
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 15 15"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M14.6427 10.4368C14.6427 10.8007 14.1821 11.1232 13.4861 11.3033C13.1057 11.4063 12.6515 11.4642 12.1654 11.4642C11.682 11.4642 11.2278 11.4063 10.8479 11.3033C10.152 11.1226 9.69141 10.8039 9.69141 10.4368C9.69141 9.86994 10.7996 9.40881 12.166 9.40881C13.5345 9.40881 14.6427 9.86941 14.6427 10.4368Z"
                    fill="white"
                  />
                  <path
                    d="M13.6891 13.8134C13.2301 13.934 12.7036 13.9978 12.1649 13.9978C11.6284 13.9978 11.103 13.934 10.645 13.8139C10.2418 13.7077 9.93104 13.5712 9.69092 13.4219V13.9096C9.69092 14.4764 10.7991 14.9375 12.1655 14.9375C13.5345 14.9375 14.6432 14.4769 14.6432 13.9096V13.4219C14.4026 13.5712 14.0923 13.7072 13.6891 13.8134Z"
                    fill="white"
                  />
                  <path
                    d="M8.89386 13.9095V12.1729V11.9875V10.2572L8.90714 10.2657C9.04261 9.28394 10.3431 8.61244 12.1648 8.61244C12.8889 8.61244 13.5306 8.71816 14.0502 8.90728V1.09312L12.3449 0.0625L10.6342 1.09312L8.9183 0.0625L7.21299 1.09312L5.50236 0.0625L3.79174 1.09312L2.07049 0.0625L0.359863 1.09312V13.535C0.359863 14.3106 0.986738 14.9375 1.76236 14.9375H9.39855C9.07555 14.6522 8.89386 14.3032 8.89386 13.9095ZM9.63283 8.49344H3.21002C2.94599 8.49344 2.73189 8.27934 2.73189 8.01531C2.73189 7.75128 2.94599 7.53719 3.21002 7.53719H9.63283C9.89686 7.53719 10.111 7.75128 10.111 8.01531C10.111 8.27934 9.89686 8.49344 9.63283 8.49344ZM3.20949 4.65622H11.2006C11.4646 4.65622 11.6787 4.87031 11.6787 5.13434C11.6787 5.39838 11.4646 5.61247 11.2006 5.61247H3.20949C2.94546 5.61247 2.73136 5.39838 2.73136 5.13434C2.73136 4.87031 2.94546 4.65622 3.20949 4.65622ZM6.80605 11.3755H3.20949C2.94546 11.3755 2.73136 11.1614 2.73136 10.8973C2.73136 10.6333 2.94546 10.4192 3.20949 10.4192H6.80658C7.07061 10.4192 7.28471 10.6333 7.28471 10.8973C7.28471 11.1614 7.07008 11.3755 6.80605 11.3755Z"
                    fill="white"
                  />
                  <path
                    d="M13.6864 12.0745C13.2381 12.1957 12.7095 12.261 12.1655 12.261C11.6231 12.261 11.0955 12.1957 10.6397 12.0724C10.2392 11.9688 9.93051 11.8344 9.69092 11.6867V12.1728C9.69092 12.5399 10.1515 12.8592 10.8474 13.0425C11.2278 13.1424 11.682 13.2003 12.1649 13.2003C12.6516 13.2003 13.1058 13.1424 13.4856 13.0425C14.1816 12.8587 14.6422 12.5367 14.6422 12.1728V11.6857C14.402 11.8344 14.0907 11.9699 13.6864 12.0745Z"
                    fill="white"
                  />
                </svg>
                <span>Invoice</span>
              </a>
            </li>
          </ul>
        </div>
        <div
          className="page-content scrollable-container"
          onClick={handlePageContentClick}
        >
          {activeIndex === 0 && <DashContent />}
          {activeIndex === 1 && <BookingsContent />}
          {activeIndex === 2 && <AppartementsContent />}
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
